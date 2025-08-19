import 'package:hive/hive.dart';
import 'package:citizenpower/models/report.dart';

class OfflineService {
  final Box _offlineBox = Hive.box('offlineReports');

  Future<List<Report>> getOfflineReports() async {
    return _offlineBox.values
        .where((item) => item['synced'] == false)
        .map((item) => item['report'] as Report)
        .toList();
  }

  Future<void> saveReportForOffline(Report report, List<File> mediaFiles) async {
    await _offlineBox.put(report.id, {
      'report': report,
      'mediaFiles': mediaFiles,
      'synced': false,
    });
  }

  Future<void> removeSyncedReport(String reportId) async {
    await _offlineBox.delete(reportId);
  }
}