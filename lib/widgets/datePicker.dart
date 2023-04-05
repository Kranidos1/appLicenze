import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class datePicker extends StatelessWidget {
  final TextEditingController dateController;

  datePicker({Key? key, required TextEditingController this.dateController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: dateController,
      //editing controller of this TextField
      decoration: InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Data di nascita" //label text of field
          ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
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
