import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0)
  late DateTime lastSync;

  Settings({required this.lastSync});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'lastSync': lastSync,
    };

    return map;
  }

  Settings.fromMap(Map<String, dynamic> map) {
    lastSync = map['lastSync'];
  }
}