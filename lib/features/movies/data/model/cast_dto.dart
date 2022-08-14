
import '../../domain/entities/cast_entity.dart';

class CastDto extends CastEntity {
  final int? castId;
  final String character;
  final String creditId;
  final int? gender;
  final int? id;
  final String name;
  final int? order;
  final String profilePath;

  const CastDto({
    this.castId,
    required this.character,
    required this.creditId,
    this.gender,
    this.id,
    required this.name,
    this.order,
    required this.profilePath,
  }) : super(
          creditId: creditId,
          name: name,
          posterPath: profilePath,
          character: character,
        );

  factory CastDto.fromJson(Map<String, dynamic> json) {
    return CastDto(
      castId: json['cast_id'],
      character: json['character'] ?? '',
      creditId: json['credit_id'] ?? '',
      gender: json['gender'],
      id: json['id'],
      name: json['name'] ?? '',
      order: json['order'],
      profilePath: json['profile_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['gender'] = gender;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['profile_path'] = profilePath;
    return data;
  }
}

class Crew {
  late String creditId;
  late String department;
  late int? gender;
  late int? id;
  late String? job;
  late String name;
  late String profilePath;

  Crew(
      {required this.creditId,
      required this.department,
      this.gender,
      this.id,
      this.job,
      required this.name,
      required this.profilePath});

  Crew.fromJson(Map<String, dynamic> json) {
    creditId = json['credit_id'] ?? '';
    department = json['department'] ?? '';
    gender = json['gender'];
    id = json['id'];
    job = json['job'];
    name = json['name'] ?? '';
    profilePath = json['profile_path'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credit_id'] = creditId;
    data['department'] = department;
    data['gender'] = gender;
    data['id'] = id;
    data['job'] = job;
    data['name'] = name;
    data['profile_path'] = profilePath;
    return data;
  }
}