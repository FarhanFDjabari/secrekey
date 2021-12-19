import 'package:equatable/equatable.dart';

class GeneratedKey extends Equatable {
  final int? id;
  final String key;
  final String description;

  const GeneratedKey({
    this.id,
    required this.key,
    required this.description,
  });

  @override
  List<Object?> get props => [id, key, description];
}
