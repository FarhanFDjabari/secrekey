import 'package:equatable/equatable.dart';
import 'package:secrekey/domain/entities/generated_key.dart';

class GeneratedKeyModel extends Equatable {
  final int? id;
  final String key;
  final String description;

  const GeneratedKeyModel({
    this.id,
    required this.key,
    required this.description,
  });

  factory GeneratedKeyModel.fromEntity(GeneratedKey generatedKey) =>
      GeneratedKeyModel(
        id: generatedKey.id,
        key: generatedKey.key,
        description: generatedKey.description,
      );

  factory GeneratedKeyModel.fromJson(Map<String, dynamic> json) =>
      GeneratedKeyModel(
        id: json['id'],
        key: json['key'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'description': description,
      };

  GeneratedKey toEntity() {
    return GeneratedKey(id: id, key: key, description: description);
  }

  @override
  List<Object?> get props => [id, key, description];
}
