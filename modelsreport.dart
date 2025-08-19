import 'package:hive/hive.dart';
import 'package:geolocator/geolocator.dart';

part 'report.g.dart';

@HiveType(typeId: 0)
class Report {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String type;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final List<String> mediaUrls;
  @HiveField(5)
  final Position location;
  @HiveField(6)
  final DateTime timestamp;
  @HiveField(7)
  final String status;
  @HiveField(8)
  final bool isEmergency;
  @HiveField(9)
  final String userId;
  @HiveField(10)
  final int upvotes;
  @HiveField(11)
  final String? assignedDepartment;
  @HiveField(12)
  final DateTime? resolutionDate;

  Report({
    required this.id,
    required this.type,
    required this.category,
    required this.description,
    required this.mediaUrls,
    required this.location,
    required this.timestamp,
    this.status = 'Submitted',
    this.isEmergency = false,
    required this.userId,
    this.upvotes = 0,
    this.assignedDepartment,
    this.resolutionDate,
  });
}