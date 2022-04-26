import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0)
  // Sorry jeff is nextSync :(
  late DateTime lastSync;

  @HiveField(1)
  late bool showAds;

  Settings({required this.lastSync, required this.showAds});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'lastSync': lastSync,
      'showAds': showAds,
    };

    return map;
  }

  Settings.fromMap(Map<String, dynamic> map) {
    lastSync = map['lastSync'];
    showAds = map['showAds'];
  }
}