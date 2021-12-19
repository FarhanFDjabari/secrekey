import 'package:dartz/dartz.dart';
import 'package:secrekey/domain/entities/generated_key.dart';
import 'package:secrekey/domain/repositories/secrekey_repository.dart';
import 'package:secrekey/util/failure.dart';

class GetAllKeyFromDB {
  final SecreKeyRepository repository;

  GetAllKeyFromDB(this.repository);

  Future<Either<Failure, List<GeneratedKey>>> execute() {
    return repository.getAllSavedKeyFromDB();
  }
}
