import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class datePicker extends StatelessWidget {
  final TextEditingController dateController;
  final String label;
  final bool enabled;
  final DateTime firstDate;

  const datePicker({Key? key, required this.dateController, required this.label, required this.enabled, required this.firstDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      enabled: enabled,
      controller: dateController,
      //editing controller of this TextField
      decoration: InputDecoration(
          icon: const Icon(Icons.calendar_today), //icon of text field
          labelText: label //label text of field
          ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: firstDate,
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          dateController.text = formattedDate;
        } else {}
      },
    );
  }
}
