import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:secrekey/data/datasources/local_datasources.dart';
import 'package:secrekey/data/models/generated_key_model.dart';
import 'package:secrekey/domain/entities/generated_key.dart';
import 'package:secrekey/domain/repositories/secrekey_repository.dart';
import 'package:secrekey/util/exception.dart';
import 'package:secrekey/util/failure.dart';

class SecreKeyRepositoriesImpl extends SecreKeyRepository {
  final LocalDatasources localDatasources;

  SecreKeyRepositoriesImpl({required this.localDatasources});

  @override
  Future<Either<Failure, String>> generateNewKey(
      {int length = 16,
      bool withNumber = false,
      bool withSymbol = false}) async {
    const String lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String symbols = '@#\$%!=+&?(){}';

    String chars = '';
    String generatedKey = 'key';
    chars += "$lowercaseLetters$uppercaseLetters";
    if (withNumber) chars += numbers;
    if (withSymbol) chars += symbols;

    try {
      do {
        generatedKey = List.generate(length, (index) {
          final randomIndex = Random.secure().nextInt(chars.length);
          return chars[randomIndex];
        }).join('');
      } while (await isKeyAlreadySaved(generatedKey));
      return Right(generatedKey);
    } catch (error) {
      return Left(CommonFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GeneratedKey>>> getAllSavedKeyFromDB() async {
    try {
      final resultModel = await localDatasources.getAllSavedKey();
      return Right(resultModel.map((result) => result.toEntity()).toList());
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<bool> isKeyAlreadySaved(String key) async {
    try {
      final resultModel = await localDatasources.getSavedKeyByQuery(key);
      return resultModel != null;
    } on DatabaseException {
      return false;
    }
  }

  @override
  Future<Either<Failure, String>> removeKeyFromDB(
      GeneratedKey generatedKey) async {
    try {
      final result = await localDatasources
          .removeKeyFromDb(GeneratedKeyModel.fromEntity(generatedKey));
      return Right(result);
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveKeyToDB(GeneratedKey generatedKey) async {
    try {
      final result = await localDatasources
          .saveKeyToDb(GeneratedKeyModel.fromEntity(generatedKey));
      return Right(result);
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, String>> exportDataFromDB() async {
    try {
      final result = await localDatasources.exportDatabase();
      return Right(result);
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, String>> importDataToDB(String directory) async {
    try {
      final result = await localDatasources.importDatabase(directory);
      return Right(result);
    } on DatabaseException catch (error) {
      return Left(DatabaseFailure(error.message));
    }
  }

  @override
  Future<bool> appVersionCheck() async {
    return false;
  }
}
