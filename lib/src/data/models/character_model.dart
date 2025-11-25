import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required String originName,
    required String locationName,
    required String imageUrl,
    required String url,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          type: type,
          gender: gender,
          originName: originName,
          locationName: locationName,
          imageUrl: imageUrl,
          url: url,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final originName = json["origin"]?["name"] ?? "Unknown";
    final locationName = json["location"]?["name"] ?? "Unknown";

    return CharacterModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"] ?? "",
      gender: json["gender"],
      originName: originName,
      locationName: locationName,
      imageUrl: json["image"],
      url: json["url"],
    );
  }
}