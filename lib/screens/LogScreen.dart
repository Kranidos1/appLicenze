import 'package:app_licenze/screens/socket/socket.dart';
import 'package:app_licenze/widgets/MyMenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_licenze/utils/Configurazioni.dart' as config;
import 'package:app_licenze/Widgets/MyCombo.dart';
import 'package:accordion/accordion.dart';

class FrameLogs extends StatefulWidget {
  FrameLogs({required this.username, required this.socket});

  String username;
  SocketService socket;

  @override
  State<StatefulWidget> createState() => FrameLogsState();
}

class FrameLogsState extends State<FrameLogs> {
  bool check = defaultTargetPlatform == TargetPlatform.windows;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
        canPop: false,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: config.coloreBackgroundCell,
          body: creaFrameCellulare(),
        )));
  }

  Widget creaFrameCellulare() {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          child: SizedBox(
            width: size.width,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyMenu(
                  username: widget.username,
                  socket: widget.socket,
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyCombo(
                      width: 150,
                      etichetta: "Filtra",
                      selectedValue: "Test",
                      possibiliScelte: [
                        {"a1": "Test", "a2": "Test"}
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Accordion(
              paddingBetweenClosedSections: 30,
              headerBackgroundColor: Colors.white,
              headerPadding: EdgeInsets.all(10),
              contentVerticalPadding: 20,
              children: [
                AccordionSection(
                    rightIcon: Icon(
                      Icons.arrow_drop_down,
                      color: config.coloreBackgroundCell,
                    ),
                    header: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        Text(
                          "Nome azienda",
                          style: TextStyle(
                              color: config.coloreBackgroundCell, fontSize: 16),
                        )
                      ],
                    ),
                    content: SizedBox(
                      height: size.height * .3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              20,
                              (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 25),
                                    child: SizedBox(
                                      height: 60,
                                      child: Card(
                                        color: Colors.white,
                                        shadowColor: Colors.green,
                                        elevation: 10,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 15, left: 10),
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                              ),
                                            ),
                                            Text(
                                              "Nome programma",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                    ))
              ]),
        )
      ],
    );
  }
}
