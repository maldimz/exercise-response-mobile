import 'package:flutter/material.dart';
import 'package:latihan_responsi/model/karakter_model.dart';
import 'package:latihan_responsi/service/genshin_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailKarakterPage extends StatefulWidget {
  String name;
  DetailKarakterPage({Key? key, required this.name}) : super(key: key);

  @override
  State<DetailKarakterPage> createState() => _DetailKarakterPageState();
}

class _DetailKarakterPageState extends State<DetailKarakterPage> {
  Future<void> _setLastOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_open', widget.name);
    prefs.setString('code', 'characters');
  }

  @override
  void initState() {
    super.initState();
    _setLastOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
              "Detail ${widget.name[0].toUpperCase()}${widget.name.substring(1).toLowerCase()}"),
        ),
        body: FutureBuilder(
          future: GenshinApi().getDetailKarakter(widget.name),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: Text("Tidak ada data"),
                ),
              );
            } else {
              KarakterModel karakter = snapshot.data;
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://api.genshin.dev/characters/${karakter.name.toLowerCase()}/gacha-splash'),
                                fit: BoxFit.cover)),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://api.genshin.dev/nations/${karakter.nation.toLowerCase()}/icon'),
                                  fit: BoxFit.cover),
                            ),
                            height: 50,
                            width: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://api.genshin.dev/elements/${karakter.visionKey.toLowerCase()}/icon'),
                                  fit: BoxFit.cover),
                            ),
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            karakter.name,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      Text(karakter.name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < karakter.rarity; i++)
                            Icon(
                              Icons.star,
                              color: Colors.white,
                            )
                        ],
                      ),
                      Text(
                        karakter.affiliation,
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          karakter.description,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      for (int i = 0; i < karakter.skillTalents.length; i++)
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(urlImageTalent(
                                          karakter.name,
                                          karakter.skillTalents[i].type!)),
                                      fit: BoxFit.cover),
                                ),
                                width: 75,
                                height: 75,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    karakter.skillTalents[i].unlock,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    karakter.skillTalents[i].name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    karakter.skillTalents[i].description,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}

String urlImageTalent(String name, String talent) {
  var split = talent.split("_");
  var tipe = split[1];

  if (split[1] == 'ATTACK') {
    tipe = 'na';
  } else {
    tipe = split[1].toLowerCase();
  }

  return "https://api.genshin.dev/characters/${name.toLowerCase()}/talent-$tipe";
}
