import 'package:hive/hive.dart';
import 'package:recipes/database/models/settings/settings.dart';

Future<void> createSettingsObject() async {
  final box = await Hive.openBox<Settings>('settings');
  // box.clear();

  getSettingsObject().then((value) async {
    if(value == null){
      Settings settings = Settings(lastSync: DateTime.now());

      await box.add(settings);
    }
  });

}

Future<Settings?> getSettingsObject() async {
  final box = await Hive.openBox<Settings>('settings');

  Settings? settings = box.get(0);

  return settings;
}

Future<bool> refreshCachedData() async {
  Settings? settings = await getSettingsObject();

  if(settings == null){
    return true;
  }else if(settings.lastSync.isAfter(DateTime.now().add(Duration(days: 7)))){
    return true;
  }

  return false;

}