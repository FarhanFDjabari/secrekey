import 'package:secrekey/domain/repositories/secrekey_repository.dart';

class CheckAppVersion {
  final SecreKeyRepository repository;

  CheckAppVersion(this.repository);

  Future<bool> execute() {
    return repository.appVersionCheck();
  }
}
