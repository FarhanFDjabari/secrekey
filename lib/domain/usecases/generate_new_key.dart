import 'package:dartz/dartz.dart';
import 'package:secrekey/domain/repositories/secrekey_repository.dart';
import 'package:secrekey/util/failure.dart';

class GenerateNewKey {
  final SecreKeyRepository repository;

  GenerateNewKey(this.repository);

  Future<Either<Failure, String>> execute(
      int length, bool withNumber, bool withSymbol) {
    return repository.generateNewKey(
      length: length,
      withNumber: withNumber,
      withSymbol: withSymbol,
    );
  }
}
