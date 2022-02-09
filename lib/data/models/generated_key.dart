import 'package:hive/hive.dart';

part 'generated_key.g.dart';

@HiveType(typeId: 0)
class GeneratedKey extends HiveObject {
  @HiveField(0)
  late String label;
  @HiveField(1)
  late String savedKey;
}
