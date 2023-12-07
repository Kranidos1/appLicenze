import 'dart:convert';

import 'package:app_licenze/screens/LoginScreen.dart';
import 'package:app_licenze/screens/StoricoScreen.dart';
import 'package:app_licenze/screens/socket/socket.dart';
import 'package:app_licenze/widgets/MyMenu.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rive/rive.dart';
import '../widgets/textField.dart';
import '../widgets/button.dart';

class LicenzeFEScreen extends StatefulWidget {
  LicenzeFEScreen(
      {Key? key,
      required String this.username,
      required SocketService this.socket});
  final SocketService socket;
  final String username;
  bool enabled = false;

  bool readOnly = false;

  late StateMachineController controller;
  late dynamic artboard;

  TextEditingController pivaController = TextEditingController();
  TextEditingController ragioneSocialeController = TextEditingController();
  TextEditingController scadenzaController = TextEditingController();
  TextEditingController nuovaScadenzaController = TextEditingController();

  @override
  State<StatefulWidget> createState() => LicenzeFEScreenState();
}

class LicenzeFEScreenState extends State<LicenzeFEScreen> {
  String selectedValue = '';
  List<DropdownMenuItem<String>> dropDownItems = [
    const DropdownMenuItem(
      value: '',
      child: Text(''),
    )
  ];
  Icon _iconaMenu = const Icon(Icons.menu);
  late bool _isMenuOpen = false;

  late bool prorogaTmp = false;
  double _sideMenuWidth = 0;
  double _pageWidth = 0;

  bool ansTrue = true;
  bool ansFalse = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: Stack(children: [
            SafeArea(
                child: Column(
              children: [
                Stack(children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: const DecoratedBox(
                              decoration:
                                  BoxDecoration(color: Color(0xFF17203A)),
                              child: Center(
                                child: Text(
                                  "LicenzeFE",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: MyMenu(
                        username: widget.username,
                        socket: widget.socket,
                      )),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: TextFormField(
                    readOnly: widget.readOnly,
                    controller: widget.pivaController,
                    obscureText: false,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(),
                        labelText: "P.IVA"),
                    validator: null,
                    onEditingComplete: onSend,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                  child: MyTextField(
                      label: "Ragione Sociale",
                      controller: widget.ragioneSocialeController,
                      obscure: false,
                      readOnly: true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                  child: TextFormField(
                    enabled: false,
                    controller: widget.scadenzaController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Scadenza"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                  child: DropdownButton(
                    value: selectedValue,
                    items: dropDownItems,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Center(
                      child: MyButton(
                          onPressed: onSave,
                          label: const Text("Salva"),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black)),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: FloatingActionButton(
                              heroTag: "button1",
                              onPressed: onStop,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              child: const Icon(Icons.stop),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: FloatingActionButton(
                                heroTag: "button2",
                                onPressed: onHistory,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: const Icon(Icons.history)),
                          )
                        ],
                      ),
                    )
                  ],
                ))
              ],
            )),
          ])),
    );
  }

  void onHistory() async {
    if (widget.readOnly) {
      String piva = widget.pivaController.text;
      final result = await widget.socket
          .gestioneStorico(username: widget.username, iva: piva);

      if (result.toString() == 'Error') {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Errore lato server."),
                  icon: Icon(Icons.warning_outlined),
                ));
      } else if (result.toString() == '2') {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Impossibile raggiungere l'host."),
                  icon: Icon(Icons.warning_outlined),
                ));
      } else if (result.toString() == '3') {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Attivare la connessione."),
                  icon: Icon(Icons.warning_outlined),
                ));
      } else {
        final List risultato = jsonDecode(result.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => StoricoScreen(
                      title: "StoricoFE",
                      values: risultato,
                    )));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Cercare prima una partita iva valida."),
                icon: Icon(Icons.warning_outlined),
              ));
    }
  }

  void onSend() async {
    //ricerca
    final result = await widget.socket.getScadenza(
        piva: widget.pivaController.text, username: widget.username);

    dynamic lista = jsonDecode(result);

    String dataStringa = lista[0];

    if (dataStringa == '2') {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Impossibile raggiungere l'host."),
                icon: Icon(Icons.warning_outlined),
              ));
    } else if (dataStringa == '3') {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Attivare la connessione."),
                icon: Icon(Icons.warning_outlined),
              ));
    } else {
      if (dataStringa == 'Error') {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Errore di connessione al database."),
                  icon: Icon(Icons.warning_outlined),
                ));
      } else if (dataStringa != 'Error') {
        bool proroga = bool.parse(lista[1].toString().toLowerCase());
        String ragioneSociale = lista[2];
        String iva = lista[3];

        widget.pivaController.text = iva;
        widget.ragioneSocialeController.text = ragioneSociale;
        widget.scadenzaController.text = dataStringa;

        List<DropdownMenuItem<String>> result = [];

        if (proroga == true) {
          prorogaTmp = true;
          //se la proroga e' attiva i 3 mesi devono essere calcolati basandoti su data - 5 (ottenendo la data prima della prorogaTmp)

          var newDate = Jiffy.parse(dataStringa)
              .subtract(days: 5)
              .add(months: 3)
              .dateTime;
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          String data1 = formatter.format(newDate);

          result.addAll([DropdownMenuItem(value: data1, child: Text(data1))]);

          //DateTime(data5.year ,data5.month ,data5.day - 5);
          //ritorni solo la data con 3 mesi in piu in quanto prorogaTmp attiva
        } else {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');

          var data5 = Jiffy.parse(dataStringa).add(days: 5).dateTime;
          var data3 = Jiffy.parse(dataStringa).add(months: 3).dateTime;

          String data1 = formatter.format(data5);
          String data2 = formatter.format(data3);

          result.addAll([
            DropdownMenuItem(value: data1, child: Text(data1)),
            DropdownMenuItem(value: data2, child: Text(data2))
          ]);
        }
        setState(() {
          dropDownItems.addAll(result);
          widget.readOnly = true;
        });
      } else {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Nessuna corrispondenza trovata nel database."),
                  icon: Icon(Icons.warning_outlined),
                ));
      }
    }
  }

  void onSave() async {
    //l'utente ha scelto una data e l'iva e' bloccata quindi tutto ok
    if (selectedValue != '') {
      String piva = widget.pivaController.text;
      String username = widget.username;
      String dataVecchia = widget.scadenzaController.text;

      if (prorogaTmp == true) {
        //la proroga era già attiva quindi ora devi settarla a false
        final value = await widget.socket.setScadenza(
            piva: piva,
            username: username,
            dataVecchia: dataVecchia,
            dataNuova: selectedValue,
            prorogaTmp: 0);

        if (value == '2') {
          showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    title: Text("Impossibile raggiungere l'host."),
                    icon: Icon(Icons.warning_outlined),
                  ));
        } else if (value == '3') {
          showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    title: Text("Attivare la connessione."),
                    icon: Icon(Icons.warning_outlined),
                  ));
        } else {
          final formattedBool = jsonDecode(value).toLowerCase() == "true";
          saveErrorHandler(formattedBool);
        }
      } else {
        if (selectedValue == dropDownItems[1].value) {
          //stai prorogando di 5 giorni

          final value = await widget.socket.setScadenza(
              piva: piva,
              username: username,
              dataVecchia: dataVecchia,
              dataNuova: selectedValue,
              prorogaTmp: 1);
          if (value == '2') {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text("Impossibile raggiungere l'host."),
                      icon: Icon(Icons.warning_outlined),
                    ));
          } else if (value == '3') {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text("Attivare la connessione."),
                      icon: Icon(Icons.warning_outlined),
                    ));
          } else {
            final formattedBool = jsonDecode(value).toLowerCase() == "true";

            saveErrorHandler(formattedBool);
          }
        } else {
          final value = await widget.socket.setScadenza(
              piva: piva,
              username: username,
              dataVecchia: dataVecchia,
              dataNuova: selectedValue,
              prorogaTmp: 0);

          if (value == '2') {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text("Impossibile raggiungere l'host."),
                      icon: Icon(Icons.warning_outlined),
                    ));
          } else if (value == '3') {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text("Attivare la connessione."),
                      icon: Icon(Icons.warning_outlined),
                    ));
          } else {
            final formattedBool = jsonDecode(value).toLowerCase() == "true";

            saveErrorHandler(formattedBool);
          }
        }
      }

      //funzione di inserimento
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Scegliere una data valida."),
                icon: Icon(Icons.warning_outlined),
              ));
    }
  }

  void onStop() {
    setState(() {
      widget.readOnly = false;
      widget.pivaController.text = '';
      widget.ragioneSocialeController.text = '';
      widget.scadenzaController.text = '';
      selectedValue = '';
      for (int i = 1; i <= dropDownItems.length; i++) {
        dropDownItems.removeLast();
      }
    });
  }

  void saveErrorHandler(dynamic risposta) {
    if (risposta == false) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Errore lato server."),
                icon: Icon(Icons.warning_outlined),
              ));
    } else {
      //tutto ok

      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Inserimento a buon fine."),
                icon: Icon(Icons.verified_rounded),
              ));
    }
    onStop();
  }

  @override
  void dispose() {
    super.dispose();

    widget.pivaController.dispose();
    widget.ragioneSocialeController.dispose();
    widget.scadenzaController.dispose();
    widget.nuovaScadenzaController.dispose();
  }
}
