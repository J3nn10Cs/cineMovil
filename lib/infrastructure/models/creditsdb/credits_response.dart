
import 'package:cinemapedia/infrastructure/models/creditsdb/cast_castdb.dart';

class CreditsResponse {
    final int id;
    final List<CastCastdb> cast;
    final List<CastCastdb> crew;

    CreditsResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory CreditsResponse.fromJson(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<CastCastdb>.from(json["cast"].map((x) => CastCastdb.fromJson(x))),
        crew: List<CastCastdb>.from(json["crew"].map((x) => CastCastdb.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    };
}

