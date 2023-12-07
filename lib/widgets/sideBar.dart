import 'package:flutter/material.dart';

class sideBar extends StatelessWidget {
  final String username;

  const sideBar({Key? key, required this.username});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(children: [
        //parte superiore prima delle opzioni

        DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange[400],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Material(
                    child: Image.asset(
                      "contents/images/logo.png",
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(username),
                )
              ],
            )),

        //parte delle opzioni : ogni Container contiene un opzione ;ogni listtile e' un opzione ;
        Container(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
          child: ListTile(
            leading: const Icon(Icons.abc),
            title: const Text("LicenzeFE"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print("ok");
            },
          ),
        ),
        Container(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
          child: ListTile(
            leading: const Icon(Icons.abc),
            title: const Text("Licenze"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print("ok");
            },
          ),
        )
      ]),
    );
  }
}
