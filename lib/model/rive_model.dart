import 'package:rive/rive.dart';

class RiveModel {
  final String src, artboard, stateMachineName, title;
  late SMIBool? status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.status,
  });

  set setStatus(SMIBool state) {
    status = state;
  }
}

List<RiveModel> sideMenus = [
  //RiveModel(src: 'contents/RiveAssets/icons.riv', artboard: "HOME", stateMachineName: "HOME_interactivity" ,title: "Home"),
  RiveModel(
      src: 'contents/RiveAssets/icons2.riv',
      artboard: "RULES",
      stateMachineName: "RULESFE_interactivity",
      title: "LicenzeFE"),
  RiveModel(
      src: 'contents/RiveAssets/icons2.riv',
      artboard: "RULES",
      stateMachineName: "RULES_interactivity",
      title: "Licenze"),
];
