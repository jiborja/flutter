import 'package:json_annotation/json_annotation.dart';

part 'dates.g.dart';

@JsonSerializable()
class Dates {
  Dates({this.maximum, this.minimum});
  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  String? maximum;
  String? minimum;

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}
