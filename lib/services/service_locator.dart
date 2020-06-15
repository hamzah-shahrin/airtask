import 'package:airtask/controllers/storage_controller.dart';
import 'package:airtask/services/storage_api.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerFactory<StorageController>(() => StorageController());
  serviceLocator.registerFactory<StorageApi>(() => FakeStorageApiImpl());
}