import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_responsi/model/karakter_model.dart';
import 'package:latihan_responsi/model/weapon_model.dart';

class GenshinApi {
  Future<List<dynamic>> getKarakter() async {
    var url = Uri.parse('https://api.genshin.dev/characters');
    var response = await http.get(url);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<List<dynamic>> getWeapon() async {
    var url = Uri.parse('https://api.genshin.dev/weapons');
    var response = await http.get(url);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<KarakterModel> getDetailKarakter(String name) async {
    var url = Uri.parse('https://api.genshin.dev/characters/$name');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return KarakterModel.fromJson(data);
  }

  Future<WeaponModel> getDetailWeapon(String name) async {
    print(name);
    var url = Uri.parse('https://api.genshin.dev/weapons/$name');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return WeaponModel.fromJson(data);
  }
}
