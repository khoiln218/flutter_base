// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import '../../../../core/utils/base_mapper.dart';
import '../../domain/entities/user_entity.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse implements BaseMapper<User> {
  SignInResponse({
    required this.id,
    required this.name,
    required this.accessToken,
    required this.refreshToken,
  });

  final int? id;
  @JsonKey(name: 'firstName')
  final String? name;
  final String? accessToken;
  final String? refreshToken;

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);

  @override
  User toEntity() {
    return User(id: (id ?? '').toString(), name: name ?? '');
  }
}
