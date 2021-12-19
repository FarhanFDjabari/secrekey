import 'package:get_it/get_it.dart';
import 'package:secrekey/data/datasources/local_datasources.dart';
import 'package:secrekey/data/datasources/secrekey_local_db.dart';
import 'package:secrekey/data/repositories/secrekey_repository_impl.dart';
import 'package:secrekey/domain/repositories/secrekey_repository.dart';
import 'package:secrekey/domain/usecases/check_app_version.dart';
import 'package:secrekey/domain/usecases/export_data_from_db.dart';
import 'package:secrekey/domain/usecases/generate_new_key.dart';
import 'package:secrekey/domain/usecases/get_all_key_from_db.dart';
import 'package:secrekey/domain/usecases/import_data_to_db.dart';
import 'package:secrekey/domain/usecases/remove_key_from_db.dart';
import 'package:secrekey/domain/usecases/save_key_to_db.dart';
import 'package:secrekey/presentation/bloc/tools/secrekey_tools_cubit.dart';
import 'package:secrekey/presentation/bloc/vault/secrekey_vault_cubit.dart';

final locator = GetIt.instance;

void init() {
  // cubit
  locator.registerFactory(() => SecreKeyToolsCubit(
        generateNewKey: locator(),
        saveKeyToDB: locator(),
      ));
  locator.registerFactory(() => SecreKeyVaultCubit(
        getAllKeyFromDB: locator(),
        removeKeyFromDB: locator(),
        importDataToDB: locator(),
        exportDataFromDB: locator(),
      ));

  // usecase
  locator.registerLazySingleton(() => GenerateNewKey(locator()));
  locator.registerLazySingleton(() => GetAllKeyFromDB(locator()));
  locator.registerLazySingleton(() => SaveKeyToDB(locator()));
  locator.registerLazySingleton(() => RemoveKeyFromDB(locator()));
  locator.registerLazySingleton(() => ImportDataToDB(locator()));
  locator.registerLazySingleton(() => ExportDataFromDB(locator()));
  locator.registerLazySingleton(() => CheckAppVersion(locator()));

  // repository
  locator.registerLazySingleton<SecreKeyRepository>(
    () => SecreKeyRepositoriesImpl(localDatasources: locator()),
  );

  // datasource
  locator.registerLazySingleton<LocalDatasources>(
    () => LocalDatasourcesImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<SecreKeyLocalDB>(() => SecreKeyLocalDB());
}
