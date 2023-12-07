import 'dart:convert';
import 'package:app_licenze/widgets/MyMenu.dart';

import 'StoricoScreen.dart';
import 'package:app_licenze/screens/socket/socket.dart';
import 'package:flutter/material.dart';
import '../widgets/datePicker.dart';
import '../widgets/button.dart';

class LicenzeScreen extends StatefulWidget {
  LicenzeScreen(
      {Key? key, required this.username, required SocketService this.socket});
  final SocketService socket;
  String username;

  @override
  State<StatefulWidget> createState() => LicenzeScreenState();
}

class LicenzeScreenState extends State<LicenzeScreen> {
  DateTime firstDate = DateTime(1950);
  bool onSearchHolder = true;
  bool onSaveHolder = true;

  bool enabled = false;
  bool readOnly = false;

  double opacityValue = 0;

  TextEditingController scaLicController = TextEditingController();
  TextEditingController scaDepositoController = TextEditingController();

  TextEditingController scadenzaController = TextEditingController();
  TextEditingController scaNotaController = TextEditingController();
  TextEditingController nuovaScadenzaController = TextEditingController();

  Icon _iconaMenu = const Icon(Icons.menu);
  late bool _isMenuOpen = false;

  double _sideMenuWidth = 0;
  double _pageWidth = 0;

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
                child: Column(children: [
              Stack(children: [
                Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: const DecoratedBox(
                            decoration: BoxDecoration(color: Color(0xFF17203A)),
                            child: Center(
                              child: Text(
                                "Licenze",
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
              SingleChildScrollView(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        readOnly: readOnly,
                        controller: scaLicController,
                        obscureText: false,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "sca_licenza"),
                        validator: null,
                        onEditingComplete: () {
                          print("ok");
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        readOnly: readOnly,
                        controller: scaDepositoController,
                        obscureText: false,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "sca_deposito"),
                        validator: null,
                        onEditingComplete: () {
                          print("ok");
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: MyButton(
                        onPressed: onSearch,
                        label: Text("Cerca"),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TextFormField(
                        style: TextStyle(fontSize: 14),
                        maxLines: 3,
                        readOnly: true,
                        controller: scaNotaController,
                        obscureText: false,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "sca_nota"),
                        validator: null,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: TextFormField(
                      readOnly: true,
                      controller: scadenzaController,
                      obscureText: false,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Scadenza"),
                      validator: null,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, left: 15, right: 15),
                    child: datePicker(
                      dateController: nuovaScadenzaController,
                      label: "Nuova Scadenza",
                      enabled: enabled,
                      firstDate: firstDate,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(
                        child: MyButton(
                            onPressed: onSave,
                            label: const Text("Salva"),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black)),
                  )
                ]),
              ),
              Expanded(
                  child: Padding(
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
              )),
            ]))
          ])),
    );
  }

  void onSearchTmp() {}

  void onHistory() async {
    if (readOnly) {
      String scaLic = scaLicController.text;
      String scaDep = scaDepositoController.text;

      final result = await widget.socket.gestioneStoricoSca(
          username: widget.username, scaDeposito: scaDep, scaLic: scaLic);

      dynamic risultato = jsonDecode(result.toString());

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
                  title: Text("Attivare la connessione"),
                  icon: Icon(Icons.warning_outlined),
                ));
      } else {
        print("$risultato");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => StoricoScreen(
                      title: "Storico",
                      values: risultato,
                    )));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title:
                    Text("Inserire e cercare prima sca_lic e sca_dep validi."),
                icon: Icon(Icons.warning_outlined),
              ));
    }
  }

  void onSearch() async {
    if (onSearchHolder == true) {
      String scaDep = scaDepositoController.text;
      String scaLic = scaLicController.text;

      if (scaDep != '' && scaLic != '') {
        final result = await widget.socket.getScadenzaSca(
            scaLic: scaLic, scaDep: scaDep, username: widget.username);

        dynamic lista = jsonDecode(result);

        if (lista is List) {
          setState(() {
            scaNotaController.text = lista[1];
            scadenzaController.text = lista[0];

            readOnly = true;
            onSearchHolder = false;
            enabled = true;
            firstDate = DateTime.parse(lista[0]);
          });
        } else {
          print(lista.runtimeType);
          if (lista == 2) {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text("Impossibile raggiungere l'host."),
                      icon: Icon(Icons.warning_outlined),
                    ));
          } else if (lista == 3) {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text("Attivare la connessione."),
                      icon: Icon(Icons.warning_outlined),
                    ));
          } else {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text(
                          "Errore lato server o non vi e' corrispondenza nel database dei codici."),
                      icon: Icon(Icons.warning_outlined),
                    ));
          }
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Entrambi i campi devono essere compilati."),
                  icon: Icon(Icons.warning_outlined),
                ));
      }
    } else {
      onSearchTmp();
    }
  }

  void onStop() {
    setState(() {
      scaDepositoController.text = '';
      scaLicController.text = '';
      scaNotaController.text = '';
      scadenzaController.text = '';
      nuovaScadenzaController.text = '';

      readOnly = false;
      onSearchHolder = true;
      enabled = false;
      firstDate = DateTime(1950);
    });
  }

  void onSave() async {
    String nuovaScadenza = nuovaScadenzaController.text;

    if (nuovaScadenza != '') {
      String vecchiaScadenza = scadenzaController.text;
      String sca_dep = scaDepositoController.text;
      String sca_lic = scaLicController.text;

      final risposta = await widget.socket.setScadenzaSca(
          username: widget.username,
          dataVecchia: vecchiaScadenza,
          dataNuova: nuovaScadenza,
          sca_dep: sca_dep,
          sca_lic: sca_lic);
      if (risposta == '2') {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Impossibile raggiungere l'host."),
                  icon: Icon(Icons.warning_outlined),
                ));
      } else if (risposta == '3') {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Attivare la connessione."),
                  icon: Icon(Icons.warning_outlined),
                ));
      } else {
        final formattedBool = jsonDecode(risposta).toLowerCase() == "true";

        saveErrorHandler(formattedBool);
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Scegliere una nuova scadenza valida"),
                icon: Icon(Icons.warning_outlined),
              ));
    }
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

    scaLicController.dispose();
    scaDepositoController.dispose();

    scadenzaController.dispose();
    scaNotaController.dispose();
    nuovaScadenzaController.dispose();
  }
}
