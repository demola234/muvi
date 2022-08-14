import 'cast_dto.dart';

class CastCrewResultDto {
  final int id;
  late final List<CastDto> cast;
  late final List<Crew> crew;

  CastCrewResultDto({required this.id, required this.cast, required this.crew});

  factory CastCrewResultDto.fromJson(Map<String, dynamic> json) {
    var cast = List<CastDto>.empty(growable: true);
    var crew = List<Crew>.empty(growable: true);
    if (json['cast'] != null) {
      json['cast'].forEach((v) {
        final castDto = CastDto.fromJson(v);
        if (_isValidCast(castDto)) {
          cast.add(CastDto.fromJson(v));
        }
      });
    }
    if (json['crew'] != null) {
      json['crew'].forEach((v) {
        final crewDto = Crew.fromJson(v);
        if (_isValidCrew(crewDto)) {
          crew.add(crewDto);
        }
      });
    }

    return CastCrewResultDto(
      id: json['id'],
      cast: cast,
      crew: crew,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cast'] = cast.map((v) => v.toJson()).toList();
    data['crew'] = crew.map((v) => v.toJson()).toList();
    return data;
  }
}

bool _isValidCast(CastDto castDto) {
  return castDto.creditId.isNotEmpty &&
      castDto.character.isNotEmpty &&
      castDto.name.isNotEmpty &&
      castDto.posterPath.isNotEmpty;
}

bool _isValidCrew(Crew crewDto) {
  return crewDto.creditId.isNotEmpty &&
      crewDto.department.isNotEmpty &&
      crewDto.name.isNotEmpty &&
      crewDto.profilePath.isNotEmpty;
}