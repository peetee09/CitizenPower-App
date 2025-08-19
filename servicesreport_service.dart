import 'package:citizenpower/models/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'dart:io';

class ReportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Box _offlineBox = Hive.box('offlineReports');

  Future<String> submitReport(Report report, List<File> mediaFiles) async {
    try {
      // Upload media files if online
      List<String> mediaUrls = [];
      if (await _checkConnectivity()) {
        for (var file in mediaFiles) {
          final ref = _storage.ref('reports/${report.id}/${DateTime.now().millisecondsSinceEpoch}');
          await ref.putFile(file);
          mediaUrls.add(await ref.getDownloadURL());
        }
        
        // Save to Firestore
        await _firestore.collection('reports').doc(report.id).set({
          'id': report.id,
          'type': report.type,
          'category': report.category,
          'description': report.description,
          'mediaUrls': mediaUrls,
          'location': GeoPoint(report.location.latitude, report.location.longitude),
          'timestamp': report.timestamp,
          'status': report.status,
          'isEmergency': report.isEmergency,
          'userId': report.userId,
          'upvotes': report.upvotes,
          'assignedDepartment': report.assignedDepartment,
        });
        
        return report.id;
      } else {
        // Save to offline storage
        await _offlineBox.put(report.id, {
          'report': report,
          'mediaFiles': mediaFiles,
          'synced': false,
        });
        return report.id;
      }
    } catch (e) {
      throw Exception('Failed to submit report: $e');
    }
  }

  Future<void> syncOfflineReports() async {
    if (!await _checkConnectivity()) return;

    final unsyncedReports = _offlineBox.values.where((item) => item['synced'] == false).toList();
    
    for (var item in unsyncedReports) {
      final report = item['report'] as Report;
      final mediaFiles = item['mediaFiles'] as List<File>;
      
      await submitReport(report, mediaFiles);
      await _offlineBox.put(report.id, {
        ...item,
        'synced': true,
      });
    }
  }

  Future<bool> _checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}