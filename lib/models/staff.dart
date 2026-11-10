import 'package:hive/hive.dart';

part 'staff.g.dart';

@HiveType(typeId: 0)
class Staff extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String role;

  Staff({required this.id, required this.name, required this.role});
}