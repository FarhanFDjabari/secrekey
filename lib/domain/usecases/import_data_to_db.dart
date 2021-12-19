import 'package:dartz/dartz.dart';
import 'package:secrekey/domain/repositories/secrekey_repository.dart';
import 'package:secrekey/util/failure.dart';

class ImportDataToDB {
  final SecreKeyRepository repository;

  ImportDataToDB(this.repository);

  Future<Either<Failure, String>> execute(String directory) {
    return repository.importDataToDB(directory);
  }
}
