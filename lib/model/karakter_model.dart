class KarakterModel {
  String name;
  String title;
  String vision;
  String weapon;
  String nation;
  String affiliation;
  int rarity;
  String constellation;
  DateTime birthday;
  String description;
  List<Constellation> skillTalents;
  List<Constellation> passiveTalents;
  List<Constellation> constellations;
  String visionKey;
  String weaponType;

  KarakterModel({
    required this.name,
    required this.title,
    required this.vision,
    required this.weapon,
    required this.nation,
    required this.affiliation,
    required this.rarity,
    required this.constellation,
    required this.birthday,
    required this.description,
    required this.skillTalents,
    required this.passiveTalents,
    required this.constellations,
    required this.visionKey,
    required this.weaponType,
  });

  factory KarakterModel.fromJson(Map<String, dynamic> json) => KarakterModel(
        name: json["name"],
        title: json["title"],
        vision: json["vision"],
        weapon: json["weapon"],
        nation: json["nation"],
        affiliation: json["affiliation"],
        rarity: json["rarity"],
        constellation: json["constellation"],
        birthday: DateTime.parse(json["birthday"]),
        description: json["description"],
        skillTalents: List<Constellation>.from(
            json["skillTalents"].map((x) => Constellation.fromJson(x))),
        passiveTalents: List<Constellation>.from(
            json["passiveTalents"].map((x) => Constellation.fromJson(x))),
        constellations: List<Constellation>.from(
            json["constellations"].map((x) => Constellation.fromJson(x))),
        visionKey: json["vision_key"],
        weaponType: json["weapon_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "vision": vision,
        "weapon": weapon,
        "nation": nation,
        "affiliation": affiliation,
        "rarity": rarity,
        "constellation": constellation,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "description": description,
        "skillTalents": List<dynamic>.from(skillTalents.map((x) => x.toJson())),
        "passiveTalents":
            List<dynamic>.from(passiveTalents.map((x) => x.toJson())),
        "constellations":
            List<dynamic>.from(constellations.map((x) => x.toJson())),
        "vision_key": visionKey,
        "weapon_type": weaponType,
      };
}

class Constellation {
  String name;
  String unlock;
  String description;
  int? level;
  String? type;

  Constellation({
    required this.name,
    required this.unlock,
    required this.description,
    this.level,
    this.type,
  });

  factory Constellation.fromJson(Map<String, dynamic> json) => Constellation(
        name: json["name"],
        unlock: json["unlock"],
        description: json["description"],
        level: json["level"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "unlock": unlock,
        "description": description,
        "level": level,
        "type": type,
      };
}
