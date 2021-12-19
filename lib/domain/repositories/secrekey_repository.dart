import 'package:dartz/dartz.dart';
import 'package:secrekey/domain/entities/generated_key.dart';
import 'package:secrekey/util/failure.dart';

abstract class SecreKeyRepository {
  Future<Either<Failure, String>> generateNewKey({
    int length = 16,
    bool withNumber = false,
    bool withSymbol = false,
  });

  Future<Either<Failure, String>> saveKeyToDB(GeneratedKey generatedKey);
  Future<Either<Failure, String>> exportDataFromDB();
  Future<Either<Failure, String>> importDataToDB(String directory);
  Future<Either<Failure, String>> removeKeyFromDB(GeneratedKey generatedKey);
  Future<Either<Failure, List<GeneratedKey>>> getAllSavedKeyFromDB();
  Future<bool> isKeyAlreadySaved(String key);
  Future<bool> appVersionCheck();
}
