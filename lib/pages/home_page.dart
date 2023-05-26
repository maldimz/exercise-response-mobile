import 'package:flutter/material.dart';
import 'package:latihan_responsi/pages/detail_karakter_page.dart';
import 'package:latihan_responsi/pages/detail_weapon_page.dart';
import 'package:latihan_responsi/pages/list_karakter_page.dart';
import 'package:latihan_responsi/pages/list_weapon_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? _lastOpen;
  String? _code;

  Future<void> _getLastOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastOpen = prefs.getString("last_open");
      _code = prefs.getString("code");
    });
  }

  @override
  void initState() {
    super.initState();
    _lastOpen = "";
    _code = "";
    _getLastOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://static.tvtropes.org/pmwiki/pub/images/gi_34.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_lastOpen != null && _lastOpen != "")
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Card(
                  child: ListTile(
                    onTap: () async {
                      if (_code == "characters") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailKarakterPage(name: _lastOpen!),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailWeaponPage(
                                name: _lastOpen!,
                              ),
                            ));
                      }
                    },
                    leading: Image.network(
                        'https://api.genshin.dev/${_code}/${_lastOpen!.toLowerCase()}/icon'),
                    title: Text(_lastOpen.toString().toUpperCase()),
                  ),
                ),
              ),
            Container(
              width: 150,
              child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListKarakterPage(),
                        ));
                    _getLastOpen();
                  },
                  child: Text("Karakter")),
            ),
            Container(
                width: 150,
                child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListWeaponPage(),
                          ));
                      _getLastOpen();
                    },
                    child: Text("Weapon")))
          ],
        ),
      ),
    );
  }
}
