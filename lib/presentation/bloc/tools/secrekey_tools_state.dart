part of 'secrekey_tools_cubit.dart';

abstract class SecrekeyToolsState extends Equatable {
  const SecrekeyToolsState();
}

class SecrekeyToolsInitial extends SecrekeyToolsState {
  @override
  List<Object> get props => [];
}

class SecrekeyToolsLoading extends SecrekeyToolsState {
  @override
  List<Object> get props => [];
}

class NewKeyGenerated extends SecrekeyToolsState {
  final String newKey;

  const NewKeyGenerated(this.newKey);

  @override
  List<Object> get props => [newKey];
}

class NewKeySaved extends SecrekeyToolsState {
  final String message;

  const NewKeySaved(this.message);

  @override
  List<Object> get props => [message];
}

class KeyGenerateFailed extends SecrekeyToolsState {
  final String message;

  const KeyGenerateFailed(this.message);

  @override
  List<Object> get props => [message];
}

class SaveKeyFailed extends SecrekeyToolsState {
  final String message;

  const SaveKeyFailed(this.message);

  @override
  List<Object> get props => [message];
}
