import 'package:music_ranking/model/info_widget.dart';
import 'package:music_ranking/model/song.dart';

class Values {
  static final Values _apiInstace = Values._internal();

  factory Values() {
    return _apiInstace;
  }
  Values._internal();

  var country = "es";
  var players = 2;
  List<InfoWidget> datos = [];
  List<Song> canciones = [];
}
