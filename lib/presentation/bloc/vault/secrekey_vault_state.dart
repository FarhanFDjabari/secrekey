part of 'secrekey_vault_cubit.dart';

abstract class SecrekeyVaultState extends Equatable {
  const SecrekeyVaultState();
}

class SecrekeyVaultInitial extends SecrekeyVaultState {
  @override
  List<Object> get props => [];
}

class SecrekeyVaultLoading extends SecrekeyVaultState {
  @override
  List<Object> get props => [];
}

class SecrekeyVaultLoaded extends SecrekeyVaultState {
  final List<GeneratedKey> generatedKeys;

  const SecrekeyVaultLoaded(this.generatedKeys);

  @override
  List<Object> get props => [generatedKeys];
}

class SecrekeyVaultLoadFailed extends SecrekeyVaultState {
  final String message;

  const SecrekeyVaultLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}

class KeyRemoveSuccess extends SecrekeyVaultState {
  final String message;

  const KeyRemoveSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ExportKeySuccess extends SecrekeyVaultState {
  final String message;

  const ExportKeySuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ImportKeySuccess extends SecrekeyVaultState {
  final String message;

  const ImportKeySuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SecrekeyVaultError extends SecrekeyVaultState {
  final String message;

  const SecrekeyVaultError(this.message);

  @override
  List<Object> get props => [message];
}
