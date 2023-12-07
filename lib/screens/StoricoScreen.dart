import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data.dart';

class StoricoScreen extends StatefulWidget {
  StoricoScreen(
      {Key? key, required String this.title, required List this.values});
  final String title;
  final List values;

  @override
  State<StatefulWidget> createState() => StoricoScreenState();
}

class StoricoScreenState extends State<StoricoScreen> {
  @override
  void initState() {
    filterData = myData;
    super.initState();
  }

  List<Data>? filterData;
  int selectedIndex = -1;

  bool sort = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF17203A),
      ),
      body: SafeArea(
          child: Column(
        children: [
          PaginatedDataTable(
            sortAscending: sort,
            sortColumnIndex: 1,
            rowsPerPage: 10,
            columns: [
              DataColumn(
                label: Text("Email"),
              ),
              DataColumn(
                label: Text("DataModifica"),
                //onSort: (columnIndex, ascending) {
                //setState(() {
                //sort = !sort;
                //});
                //onSortColumn(columnIndex, ascending);
                //}
              ),
              DataColumn(label: Text("DataNuova")),
              DataColumn(
                label: Text("DataVecchia"),
              )
            ],
            source: MyData(
                myData: widget.values,
                count: widget.values.length,
                selectRow: selectRow,
                selectedIndex: selectedIndex),
            columnSpacing: 100,
          )
        ],
      )),
    ));
  }
  /*
  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 2) {
      if (ascending) {
        filterData!.sort((a, b) => a.dataModifica!.compareTo(b.dataModifica!));
      } else {
        filterData!.sort((a, b) => b.dataModifica!.compareTo(a.dataModifica!));
      }
    }
  }
  */

  void selectRow(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class MyData extends DataTableSource {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  var myData;
  final count;
  Function selectRow;
  int selectedIndex;

  MyData(
      {required this.myData,
      required this.count,
      required this.selectRow,
      required this.selectedIndex});

  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    if (index < rowCount) {
      return recentFileDataRow(myData![index], selectRow, index);
    } else
      return null;
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => count;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

  DataRow recentFileDataRow(var data, Function selectRow, int index) {
    print("$data");
    return DataRow(
        selected: index == selectedIndex,
        onSelectChanged: (value) {
          selectRow(index);
        },
        cells: [
          DataCell(Text(data[0] ?? "email")),
          DataCell(Text(data[1])),
          DataCell(Text(data[3])),
          DataCell(Text(data[2])),
        ]);
  }
}
