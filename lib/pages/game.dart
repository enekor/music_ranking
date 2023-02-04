import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_ranking/model/info_widget.dart';
import 'package:music_ranking/utils/top_reader.dart';
import 'package:music_ranking/values.dart';
import 'package:music_ranking/widgets/widgets.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: TopReader().getSongs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return orientation == Orientation.portrait
                  ? vertical()
                  : horizontal();
            } else {
              return Padding(
                padding: const EdgeInsets.all(60.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //const CircularProgressIndicator(),
                      AnimatedIcon(
                        icon: AnimatedIcons.search_ellipsis,
                        progress: animation,
                        size: 50.0,
                        color: Colors.pink.shade500,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "buscando canciones",
                        style: GoogleFonts.ubuntu(
                            textStyle: const TextStyle(
                                fontSize: 19, letterSpacing: 0.1)),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  onTap(InfoWidget info) {
    setState(() {
      info.tocado = !info.tocado;
    });
  }

  setReaction(InfoWidget info, int type) {
    setState(() {
      info.cualificacion = type;
    });
  }

  Widget vertical() => Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 60),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      Values().canciones[0].nombre,
                      style: GoogleFonts.bakbakOne(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          letterSpacing: 0.01,
                          color: Color.fromARGB(255, 6, 21, 26),
                        ),
                      ),
                      selectionColor: Colors.purple.shade800,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: 300,
                  width: (300.0 * Values().players),
                  child: ListView.builder(
                    itemCount: Values().players,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Marcador(
                          Values().datos[index], setReaction, onTap, getColor);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget horizontal() => Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      Values().canciones[0].nombre,
                      style: GoogleFonts.bakbakOne(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          letterSpacing: 0.01,
                          color: Color.fromARGB(255, 6, 21, 26),
                        ),
                      ),
                      selectionColor: Colors.purple.shade800,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 300,
                  width: (300.0 * Values().players),
                  child: ListView.builder(
                    itemCount: Values().players,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Marcador(
                          Values().datos[index], setReaction, onTap, getColor);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

Color getColor(InfoWidget info) {
  Color ret;

  if (info.nota == "" || info.cualificacion == null) {
    ret = const Color.fromARGB(255, 229, 221, 230);
  } else {
    if (info.cualificacion == 0) {
      ret = const Color.fromARGB(255, 255, 150, 136);
    } else if (info.cualificacion == 1) {
      ret = const Color.fromARGB(255, 255, 218, 158);
    } else {
      ret = const Color.fromARGB(255, 165, 238, 160);
    }
  }

  return ret;
}
