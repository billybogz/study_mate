import 'package:json_annotation/json_annotation.dart';

part 'options_entity.g.dart';

@JsonSerializable()
class OptionsEntity {
  final String value;
  final bool isSelected;
  final bool? isCorrect;

  OptionsEntity({
    required this.value,
    this.isSelected = false,
    this.isCorrect,
  });

  factory OptionsEntity.fromJson(Map<String, dynamic> json) =>
      _$OptionsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$OptionsEntityToJson(this);
}
