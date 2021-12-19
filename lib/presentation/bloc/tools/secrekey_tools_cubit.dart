import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secrekey/domain/usecases/generate_new_key.dart';
import 'package:secrekey/domain/usecases/save_key_to_db.dart';

part 'secrekey_tools_state.dart';

class SecreKeyToolsCubit extends Cubit<SecrekeyToolsState> {
  SecreKeyToolsCubit({required this.generateNewKey, required this.saveKeyToDB})
      : super(SecrekeyToolsInitial());
  final GenerateNewKey generateNewKey;
  final SaveKeyToDB saveKeyToDB;

  void generateKey(int length, bool withNumber, bool withSymbol) async {
    emit(SecrekeyToolsLoading());
    final newKey = await generateNewKey.execute(length, withNumber, withSymbol);
    newKey.fold(
      (l) => emit(KeyGenerateFailed(l.message)),
      (r) => emit(NewKeyGenerated(r)),
    );
  }

  void saveKey(String key, String description) async {
    emit(SecrekeyToolsLoading());
    final result = await saveKeyToDB.execute(key, description);
    result.fold(
      (l) => emit(SaveKeyFailed(l.message)),
      (r) => emit(NewKeySaved(r)),
    );
  }
}
