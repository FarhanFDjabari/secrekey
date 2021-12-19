import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'secrekey_settings_state.dart';

class SecrekeySettingsCubit extends Cubit<SecrekeySettingsState> {
  SecrekeySettingsCubit() : super(SecrekeySettingsInitial());
}
