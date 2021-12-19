import 'package:dartz/dartz.dart';
import 'package:secrekey/domain/entities/generated_key.dart';
import 'package:secrekey/domain/repositories/secrekey_repository.dart';
import 'package:secrekey/util/failure.dart';

class RemoveKeyFromDB {
  final SecreKeyRepository repository;

  RemoveKeyFromDB(this.repository);

  Future<Either<Failure, String>> execute(GeneratedKey generatedKey) {
    return repository.removeKeyFromDB(generatedKey);
  }
}
