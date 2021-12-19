import 'package:secrekey/data/datasources/secrekey_local_db.dart';
import 'package:secrekey/data/models/generated_key_model.dart';
import 'package:secrekey/util/exception.dart';

abstract class LocalDatasources {
  Future<List<GeneratedKeyModel>> getAllSavedKey();
  Future<GeneratedKeyModel?> getSavedKeyByQuery(String query);
  Future<String> saveKeyToDb(GeneratedKeyModel generatedKeyModel);
  Future<String> removeKeyFromDb(GeneratedKeyModel generatedKeyModel);
  Future<String> exportDatabase();
  Future<String> importDatabase(String directory);
}

class LocalDatasourcesImpl extends LocalDatasources {
  final SecreKeyLocalDB databaseHelper;

  LocalDatasourcesImpl({required this.databaseHelper});

  @override
  Future<List<GeneratedKeyModel>> getAllSavedKey() async {
    try {
      final savedKeyList = await databaseHelper.getKeyFromDB();
      if (savedKeyList != null) {
        return savedKeyList
            .map((data) => GeneratedKeyModel.fromJson(data))
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      throw DatabaseException(error.toString());
    }
  }

  @override
  Future<GeneratedKeyModel?> getSavedKeyByQuery(String query) async {
    try {
      final savedKey = await databaseHelper.getKeyFromDbByKey(query);
      if (savedKey != null) {
        return GeneratedKeyModel.fromJson(savedKey);
      } else {
        return null;
      }
    } catch (error) {
      throw DatabaseException(error.toString());
    }
  }

  @override
  Future<String> removeKeyFromDb(GeneratedKeyModel generatedKeyModel) async {
    try {
      await databaseHelper.removeKeyFromDB(generatedKeyModel);
      return 'Berhasil dihapus dari penyimpanan';
    } catch (error) {
      throw DatabaseException(error.toString());
    }
  }

  @override
  Future<String> saveKeyToDb(GeneratedKeyModel generatedKeyModel) async {
    try {
      await databaseHelper.insertKeyToDB(generatedKeyModel);
      return 'Berhasil disimpan ke penyimpanan';
    } catch (error) {
      throw DatabaseException(error.toString());
    }
  }

  @override
  Future<String> exportDatabase() async {
    try {
      final dbLocation = await databaseHelper.exportDB();
      return 'Data berhasil di export pada $dbLocation';
    } catch (error) {
      throw DatabaseException(error.toString());
    }
  }

  @override
  Future<String> importDatabase(String directory) async {
    try {
      await databaseHelper.importDB(directory);
      return 'Database behasil di import';
    } catch (error) {
      throw DatabaseException(error.toString());
    }
  }
}
