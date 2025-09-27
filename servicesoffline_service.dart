import 'package:hive/hive.dart';
import 'package:citizenpower/models/report.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OfflineService {
  late final Box _offlineBox;

  OfflineService() {
    if (!kIsWeb) {
      _offlineBox = Hive.box('offlineReports');
    }
  }

  Future<List<Report>> getOfflineReports() async {
    if (kIsWeb) {
      return []; // Offline storage not supported on web
    }
    return _offlineBox.values
        .where((item) => item['synced'] == false)
        .map((item) => item['report'] as Report)
        .toList();
  }

  Future<void> saveReportForOffline(Report report, List<dynamic> mediaFiles) async {
    if (kIsWeb) {
      // Web: Always try to sync immediately
      return;
    }
    await _offlineBox.put(report.id, {
      'report': report,
      'mediaFiles': mediaFiles,
      'synced': false,
    });
  }

  Future<void> removeSyncedReport(String reportId) async {
    if (!kIsWeb) {
      await _offlineBox.delete(reportId);
    }
  }
}
