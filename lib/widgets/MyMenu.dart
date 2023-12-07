import 'package:app_licenze/screens/LicenzeFEScreen.dart';
import 'package:app_licenze/screens/LicenzeScreen.dart';
import 'package:app_licenze/screens/LogScreen.dart';
import 'package:app_licenze/screens/socket/socket.dart';
import 'package:flutter/material.dart';

class MyMenu extends StatefulWidget {
  MyMenu({required this.username, required this.socket});

  @override
  State<StatefulWidget> createState() => MyMenuState();

  String username;
  SocketService socket;
}

class MyMenuState extends State<MyMenu> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        InkWell(
          onTap: apriDialogoMenu,
          child: Icon(
            Icons.menu,
            color: Colors.white,
            size: 25,
          ),
        )
      ],
    );
  }

  void apriDialogoMenu() {
    Size size = MediaQuery.of(context).size;
    double startingY = size.height * .6;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (ctx, setStat) {
            Size size = MediaQuery.of(ctx).size;
            return Material(
              color: Colors.transparent,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  width: size.width,
                  height: startingY,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanUpdate: (details) {
                            double value =
                                (size.height - details.globalPosition.dy);

                            if (value < size.height * .2 ||
                                value > size.height * .8) {
                              Navigator.pop(context);
                            } else {
                              setStat(() {
                                startingY =
                                    (size.height - details.globalPosition.dy);
                              });
                            }
                            setState(() {
                              startingY =
                                  (size.height - details.globalPosition.dy);
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Divider(
                              color: Colors.white,
                              thickness: 3,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 15, right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LicenzeFEScreen(
                                                    username: widget.username,
                                                    socket: widget.socket)));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.list_alt,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Licenze FE",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LicenzeScreen(
                                                    username: widget.username,
                                                    socket: widget.socket)));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.view_list,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Licenze",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: InkWell(
                                  onTap: () {
                                    //log
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FrameLogs(
                                                    username: widget.username,
                                                    socket: widget.socket)));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.router,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Log clienti",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.logout,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            );
          });
        });
  }
}
