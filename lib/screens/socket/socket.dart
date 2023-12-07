import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class SocketService {
  late int port;
  late String host;

  SocketService() {
    dynamic callback = (result) {
      port = int.parse(result['port']);
      host = result['host'];
    };
    getInfo(callback);
  }

  void getInfo(dynamic callback) async {
    String uri =
        "http://www.mareasistemi.it/getlicenzaapp.php?imei=applicenze&ip=0&licenza=3389";

    var res = await http.get(Uri.parse(uri));

    dynamic result = jsonDecode(res.body);

    callback(result);
  }

  Future<int> login(String username, String password) async {
    final completer = Completer<int>();

    try {
      final socket = await Socket.connect(host, port);

      socket.write(json.encode(
          {"funzione": "login", "username": username, "password": password}));

      socket.listen((data) {
        completer.complete(int.parse(String.fromCharCodes(data)));
      }, onDone: () {
        socket.destroy();
      }, onError: (error) {
        print("$error");
      });

      return completer.future;
    } catch (e) {
      //errore generato o da mancanza di connessione o da host non raggiungibile
      final exception = e.toString().substring(0, 33);
      return 2;
    }
  }

  Future<String> getScadenza(
      {required String piva, required String username}) async {
    final completer = Completer<String>();

    try {
      final socket = await Socket.connect(host, port);

      socket.write(json.encode(
          {"funzione": "getScadenza", "username": username, "iva": piva}));

      socket.listen((data) {
        completer.complete(String.fromCharCodes(data));
      }, onDone: () {
        socket.destroy();
      }, onError: (error) {
        print("$error");
      });

      return completer.future;
    } catch (e) {
      //errore generato o da mancanza di connessione o da host non raggiungibile

      final exception = e.toString().substring(0, 33);

      if (exception == "SocketException: No route to host") {
        completer.complete(jsonEncode(['2']));
        return completer.future;
      } else {
        completer.complete(jsonEncode(['3']));
        return completer.future;
      }
    }
  }

  Future<String> setScadenza(
      {required String piva,
      required String username,
      required String dataVecchia,
      required String dataNuova,
      required int prorogaTmp}) async {
    final completer = Completer<String>();

    try {
      final socket = await Socket.connect(host, port);

      socket.write(json.encode({
        "funzione": "setScadenza",
        "username": username,
        "iva": piva,
        "dataVecchia": dataVecchia,
        "dataNuova": dataNuova,
        "prorogaTmp": prorogaTmp.toString(),
      }));

      socket.listen((data) {
        completer.complete(String.fromCharCodes(data));
      }, onDone: () {
        socket.destroy();
      }, onError: (error) {
        print("$error");
      });

      return completer.future;
    } catch (e) {
      final exception = e.toString().substring(0, 33);

      if (exception == "SocketException: No route to host") {
        completer.complete("2");
        return completer.future;
      } else {
        completer.complete("3");
        return completer.future;
      }
    }
  }

  Future<String> getScadenzaSca(
      {required String scaLic,
      required String scaDep,
      required String username}) async {
    final completer = Completer<String>();

    try {
      final socket = await Socket.connect(host, port);

      socket.write(json.encode({
        "funzione": "getScadenzaSca",
        "username": username,
        "scaLic": scaLic,
        "scaDep": scaDep
      }));

      socket.listen((data) {
        completer.complete(String.fromCharCodes(data));
      }, onDone: () {
        socket.destroy();
      }, onError: (error) {
        print("$error");
      });

      return completer.future;
    } catch (e) {
      final exception = e.toString().substring(0, 33);

      if (exception == "SocketException: No route to host") {
        completer.complete('2');
        return completer.future;
      } else {
        completer.complete('3');
        return completer.future;
      }
    }
  }

  Future<String> setScadenzaSca(
      {required String username,
      required String dataVecchia,
      required String dataNuova,
      required String sca_dep,
      required String sca_lic}) async {
    final completer = Completer<String>();

    try {
      final socket = await Socket.connect(host, port);

      socket.write(json.encode({
        "funzione": "setScadenzaSca",
        "username": username,
        "dataVecchia": dataVecchia,
        "dataNuova": dataNuova,
        "sca_dep": sca_dep,
        "sca_lic": sca_lic
      }));

      socket.listen((data) {
        completer.complete(String.fromCharCodes(data));
      }, onDone: () {
        socket.destroy();
      }, onError: (error) {
        print("$error");
      });

      return completer.future;
    } catch (e) {
      final exception = e.toString().substring(0, 33);

      if (exception == "SocketException: No route to host") {
        completer.complete('2');
        return completer.future;
      } else {
        completer.complete('3');
        return completer.future;
      }
    }
  }

  Future<String> gestioneStorico(
      {required String username, required String iva}) async {
    final completer = Completer<String>();

    try {
      final socket = await Socket.connect(host, port);

      socket.write(json.encode(
          {"funzione": "gestioneStorico", "username": username, "iva": iva}));

      socket.listen((data) {
        completer.complete(String.fromCharCodes(data));
      }, onDone: () {
        socket.destroy();
      }, onError: (error) {
        print("$error");
      });

      return completer.future;
    } catch (e) {
      final exception = e.toString().substring(0, 33);

      if (exception == "SocketException: No route to host") {
        completer.complete('2');
        return completer.future;
      } else {
        completer.complete('3');
        return completer.future;
      }
    }
  }

  Future<String> gestioneStoricoSca(
      {required String username,
      required String scaDeposito,
      required String scaLic}) async {
    final completer = Completer<String>();

    try {
      final socket = await Socket.connect(host, port);

      socket.write(json.encode({
        "funzione": "gestioneStoricoSca",
        "username": username,
        "scaLic": scaLic,
        "scaDep": scaDeposito
      }));

      socket.listen((data) {
        completer.complete(String.fromCharCodes(data));
      }, onDone: () {
        socket.destroy();
      }, onError: (error) {
        print("$error");
      });

      return completer.future;
    } catch (e) {
      final exception = e.toString().substring(0, 33);

      if (exception == "SocketException: No route to host") {
        completer.complete('2');
        return completer.future;
      } else {
        completer.complete('3');
        return completer.future;
      }
    }
  }
}
