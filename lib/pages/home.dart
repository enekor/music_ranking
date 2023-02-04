import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_ranking/model/info_widget.dart';
import 'package:music_ranking/pages/game.dart';
import 'package:music_ranking/values.dart';
import 'package:music_ranking/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RxBool paisExists = false.obs;
  RxInt isValid = (-1).obs;
  RxBool showPutNames = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        changeCountry(String termination) {
          setState(() {
            paisExists.value = termination != "";
            if (termination == "") {
              isValid.value = 0;
            }

            Values().country = termination;
          });
        }

        changePlayers(int players) {
          if (players <= 0) {
            isValid.value = 0;
          }
          players > -1 ? Values().players = players : isValid.value = 0;
        }

        enableNames() {
          Values().datos = [];
          for (int i = 0; i < Values().players; i++) {
            Values().datos.add(InfoWidget(false, "nombre $i", ""));
          }

          showPutNames.value = true;
        }

        checkLink() {
          isValid.value = 1;
        }

        open() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Game(),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: !showPutNames.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                paisExists.value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Text(
                                              "www.youtube.${Values().country}",
                                              style: TextStyle(
                                                  color: isValid.value != -1
                                                      ? isValid.value == 1
                                                          ? Colors.black
                                                          : Colors.red
                                                      : Colors.black),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: IconButton(
                                              onPressed: checkLink,
                                              icon: const Icon(Icons
                                                  .check_circle_outline_rounded),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                const SizedBox(height: 15),
                                CTextField(changeCountry, "Country",
                                    Icons.map_rounded),
                                const SizedBox(height: 15),
                                NumberTextField(changePlayers, "Players"),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                              onPressed:
                                  isValid.value == 1 ? enableNames : null,
                              icon:
                                  const Icon(Icons.play_circle_filled_rounded),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        //nombres de los participantes----------------------------------------
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Values().players * 60,
                            width: double.maxFinite,
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: Values().players,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 60,
                                  width: double.maxFinite,
                                  child: Center(
                                    child: CTextField((value) {
                                      Values().datos[index].nombre = value;
                                    }, "Jugador ${index + 1}",
                                        Icons.person_add),
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    showPutNames.value = false;
                                  },
                                  child: const Text("Cancel")),
                              ElevatedButton(
                                  onPressed: open, child: const Text("Ok"))
                            ],
                          )
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
