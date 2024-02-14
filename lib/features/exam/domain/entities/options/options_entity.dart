import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'options_entity.g.dart';

@JsonSerializable()
class OptionsEntity extends Equatable {
  final String value;
  final bool isSelected;
  final bool? isCorrect;

  const OptionsEntity({
    required this.value,
    this.isSelected = false,
    this.isCorrect,
  });

  factory OptionsEntity.fromJson(Map<String, dynamic> json) =>
      _$OptionsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$OptionsEntityToJson(this);

  @override
  String toString() {
    return 'OptionsEntity(value: $value)';
  }

  @override
  List<Object?> get props => <Object?>[value, isSelected, isCorrect];
}
