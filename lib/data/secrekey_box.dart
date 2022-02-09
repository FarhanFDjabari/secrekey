import 'package:hive/hive.dart';
import 'package:secrekey/data/models/generated_key.dart';

class SecreKeyBox {
  static Box<GeneratedKey> getGeneratedKeys() =>
      Hive.box<GeneratedKey>('secreKey');
}
