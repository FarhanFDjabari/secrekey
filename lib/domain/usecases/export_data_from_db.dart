import 'package:dartz/dartz.dart';
import 'package:secrekey/domain/repositories/secrekey_repository.dart';
import 'package:secrekey/util/failure.dart';

class ExportDataFromDB {
  final SecreKeyRepository repository;

  ExportDataFromDB(this.repository);

  Future<Either<Failure, String>> execute() {
    return repository.exportDataFromDB();
  }
}
