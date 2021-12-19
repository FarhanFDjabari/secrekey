import 'package:dartz/dartz.dart';
import 'package:secrekey/domain/entities/generated_key.dart';
import 'package:secrekey/domain/repositories/secrekey_repository.dart';
import 'package:secrekey/util/failure.dart';

class SaveKeyToDB {
  final SecreKeyRepository repository;

  SaveKeyToDB(this.repository);

  Future<Either<Failure, String>> execute(String key, String description) {
    final generatedKey = GeneratedKey(key: key, description: description);
    return repository.saveKeyToDB(generatedKey);
  }
}
