import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_ranking/model/info_widget.dart';
import 'package:music_ranking/values.dart';

Widget CTextField(dynamic onChange, String texto, IconData icono) => TextField(
      //style: TextStyle(color: ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //labelStyle: TextStyle(color: ),
        suffixIcon: Icon(icono),
        labelText: texto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          //borderSide: BorderSide(color:),
        ),
        /*focusedBorder: const OutlineInputBorder(
             borderSide: BorderSide(color: ),
            ),*/
      ),
      onChanged: ((value) => onChange(value)),
    );

Widget NumberTextField(dynamic onChange, String texto) => SizedBox(
      width: 100,
      child: TextFormField(
        initialValue: Values().players.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          labelText: texto,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onChanged: ((value) {
          try {
            onChange(int.parse(value));
          } catch (e) {
            onChange(-1);
          }
        }),
      ),
    );

Widget Marcador(InfoWidget info, dynamic setReaction, dynamic onTap,
        dynamic getColor) =>
    GestureDetector(
      onTap: () => onTap(info),
      child: SizedBox(
        width: 300,
        height: 200,
        child: Column(
          children: [
            Card(
              color: getColor(info),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 10,
              margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(
                  child: info.tocado == true
                      ? MarcadorTextBox(
                          (value) => info.nota = value,
                          info.nota,
                        )
                      : Text(info.nota == "" ? info.nombre : info.nota),
                ),
              ),
            ),
            info.nota != ""
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 4.5,
                    ),
                    child: Card(
                      color: getColor(info),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => setReaction(info, 0),
                            icon: const Text(
                              '😟',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          IconButton(
                            onPressed: () => setReaction(info, 1),
                            icon: const Text(
                              '😕',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          IconButton(
                            onPressed: () => setReaction(info, 2),
                            icon: const Text(
                              '😀',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );

Widget MarcadorTextBox(dynamic onChange, String text) => TextFormField(
      onChanged: onChange,
      initialValue: text,
    );
