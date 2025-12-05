// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import '../../../../core/utils/base_mapper.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel implements BaseMapper<User> {
  UserModel({this.id, this.name});

  final int? id;
  final String? name;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  User toEntity() => User(id: (id ?? '').toString(), name: name ?? '');
}
