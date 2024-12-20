import 'package:hive_flutter/hive_flutter.dart';
import 'package:practical_class_01/features/locations/data/database/database_manager.dart';
import 'package:practical_class_01/features/locations/domain/model/location.dart';

class HiveDatabaseManager implements DatabaseManager {
  static const boxName = 'locations';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Location>(LocationAdapter());
    await Hive.openBox<Location>(boxName);
  }

  @override
  List<Location> getAllLocations() => Hive.box<Location>(boxName).values.toList();

  @override
  void removeAsFavorite(Location location) => Hive.box<Location>(boxName).delete(location.id);

  @override
  void setAsFavorite(Location location) => Hive.box<Location>(boxName).put(location.id, location);
}
