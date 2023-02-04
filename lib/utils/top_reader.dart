import 'package:music_ranking/model/song.dart';
import 'package:music_ranking/values.dart';
import 'package:http/http.dart' as http;

class TopReader {
  Set<String> preUrls = {};
  List<String> urls = [];
  Set<String> preNombres = {};
  List<String> nombres = [];

  String url =
      "https://www.youtube.com/feed/trending?bp=4gINGgt5dG1hX2NoYXJ0cw%3D%3D&gl=${Values().country.toUpperCase()}";

  Future<bool> getSongs() async {
    Values().canciones = [];
    var response = await http.get(Uri.parse(url));
    String ans = response.body;
    print(ans);

    //videoId "title":{"runs":[{"text":
    var listado = ans.split("videoId");
    listado.forEach((element) {
      preUrls.add(element.substring(2, 14));

      if (element.contains('"title":{"runs":[{"text":')) {
        var listNombre = element.split('"title":{"runs":[{"text":');
        preNombres.add(listNombre[1]);
      }
    });

    preUrls.forEach((element) {
      if (element.startsWith('"')) {
        urls.add(element.replaceAll('"', ''));
      }
    });

    preNombres.forEach((element) {
      String nombre = element;
      if (nombre.startsWith('"')) {
        nombre = nombre.replaceAll('"', '');
        int pos = nombre.indexOf('}');
        nombre = nombre.substring(0, pos);
        nombres.add(nombre);
      }
    });

    for (int i = 0; i < urls.length; i++) {
      Song cancion = Song(nombres[i], urls[i]);
      Values().canciones.add(cancion);
    }

    var aaa = Values().canciones;

    return true;
  }
}
