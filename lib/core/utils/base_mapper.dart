abstract class BaseMapper<Entity> {
  Entity toEntity();

  Map<String, dynamic> toJson();
}
