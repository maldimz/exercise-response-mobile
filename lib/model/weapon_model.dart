class WeaponModel {
  String name;
  String type;
  int rarity;
  int baseAttack;
  String subStat;
  String passiveName;
  String passiveDesc;
  String location;
  String ascensionMaterial;

  WeaponModel({
    required this.name,
    required this.type,
    required this.rarity,
    required this.baseAttack,
    required this.subStat,
    required this.passiveName,
    required this.passiveDesc,
    required this.location,
    required this.ascensionMaterial,
  });

  factory WeaponModel.fromJson(Map<String, dynamic> json) => WeaponModel(
        name: json["name"],
        type: json["type"],
        rarity: json["rarity"],
        baseAttack: json["baseAttack"],
        subStat: json["subStat"],
        passiveName: json["passiveName"],
        passiveDesc: json["passiveDesc"],
        location: json["location"],
        ascensionMaterial: json["ascensionMaterial"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "rarity": rarity,
        "baseAttack": baseAttack,
        "subStat": subStat,
        "passiveName": passiveName,
        "passiveDesc": passiveDesc,
        "location": location,
        "ascensionMaterial": ascensionMaterial,
      };
}
