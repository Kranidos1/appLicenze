import 'package:flutter/material.dart';
import 'package:app_licenze/utils/Configurazioni.dart' as config;

class MyCombo extends StatefulWidget {
  MyCombo({
    Key? key,
    String? this.selectedValue,
    List? this.possibiliScelte,
    Function? this.onChanged,
    Color? this.dropdownColor,
    TextStyle? this.textStyle,
    String this.etichetta = "",
    double? this.width,
  });

  String? selectedValue;
  List? possibiliScelte;
  Function? onChanged;
  Color? dropdownColor;
  TextStyle? textStyle;
  double? width;
  String etichetta;

  String hint = "";
  bool conEtichetta = false;

  dynamic innerMethod;

  @override
  State<StatefulWidget> createState() => MyComboState();

  dynamic getValue;
  dynamic setScelte;
  dynamic setValue;
}

class MyComboState extends State<MyCombo> {
  @override
  void initState() {
    widget.getValue = getValue;
    widget.setScelte = setScelte;
    widget.setValue = setValue;

    widget.innerMethod != null ? widget.innerMethod() : () {};
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            dropdownColor: config.coloreBackgroundCell.withOpacity(1),
            isExpanded: true,
            value: widget.possibiliScelte!
                .where((element) => element!['a1'] == widget.selectedValue)
                .firstOrNull,
            items: List.generate(widget.possibiliScelte!.length, ((index) {
              return DropdownMenuItem(
                child: Text(
                  widget.possibiliScelte![index]['a2'],
                  style: TextStyle(color: Colors.white),
                ),
                value: widget.possibiliScelte![index],
                onTap: () {},
              );
            })),
            onChanged: (Object? value) {
              Map val = value as Map;
              setState(() {
                widget.selectedValue = val!['a1'];
                if (widget.onChanged != null) {
                  widget.onChanged!(val['a1']);
                }
              });
            },
          ),
        ),
      ),
    );
  }

  String getValue() {
    return widget.selectedValue!;
  }

  void setScelte(data) {
    setState(() {
      widget.possibiliScelte = data;
    });
  }

  void setValue(String a1) {
    setState(() {
      widget.selectedValue = a1;
    });
  }
}
