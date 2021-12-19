import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secrekey/domain/entities/generated_key.dart';
import 'package:secrekey/domain/usecases/export_data_from_db.dart';
import 'package:secrekey/domain/usecases/get_all_key_from_db.dart';
import 'package:secrekey/domain/usecases/import_data_to_db.dart';
import 'package:secrekey/domain/usecases/remove_key_from_db.dart';

part 'secrekey_vault_state.dart';

class SecreKeyVaultCubit extends Cubit<SecrekeyVaultState> {
  SecreKeyVaultCubit({
    required this.getAllKeyFromDB,
    required this.removeKeyFromDB,
    required this.importDataToDB,
    required this.exportDataFromDB,
  }) : super(SecrekeyVaultInitial());
  final GetAllKeyFromDB getAllKeyFromDB;
  final RemoveKeyFromDB removeKeyFromDB;
  final ExportDataFromDB exportDataFromDB;
  final ImportDataToDB importDataToDB;

  void getAllSavedKey() async {
    emit(SecrekeyVaultLoading());
    final result = await getAllKeyFromDB.execute();
    result.fold(
      (l) => emit(SecrekeyVaultLoadFailed(l.message)),
      (r) => emit(SecrekeyVaultLoaded(r)),
    );
  }

  void removeSavedKey(GeneratedKey generatedKey) async {
    emit(SecrekeyVaultLoading());
    final result = await removeKeyFromDB.execute(generatedKey);
    result.fold(
      (l) => emit(SecrekeyVaultError(l.message)),
      (r) => emit(KeyRemoveSuccess(r)),
    );
  }

  void exportSavedKey() async {
    emit(SecrekeyVaultLoading());
    final result = await exportDataFromDB.execute();
    result.fold(
      (l) => emit(SecrekeyVaultError(l.message)),
      (r) => emit(ExportKeySuccess(r)),
    );
  }

  void importSavedKey(String directory) async {
    emit(SecrekeyVaultLoading());
    final result = await importDataToDB.execute(directory);
    result.fold(
      (l) => emit(SecrekeyVaultError(l.message)),
      (r) => emit(ImportKeySuccess(r)),
    );
  }
}
