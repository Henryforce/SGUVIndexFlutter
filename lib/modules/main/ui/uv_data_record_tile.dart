import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sguvindex/modules/main/data/uv_ui_data.dart';

class UVDataRecordTile extends StatelessWidget {
  const UVDataRecordTile({Key? key, required this.record}) : super(key: key);

  final UVUIData record;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: _buildTitle(context),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          _addText(record.date, alignment: Alignment.centerRight),
          _addText(record.uvValue, fontSize: 36, fontWeight: FontWeight.bold),
          _addText(record.uvDescription, alignment: Alignment.centerLeft),
        ],
      ),
    );
  }

  Widget _addText(String string,
      {Alignment alignment = Alignment.center,
      FontWeight fontWeight = FontWeight.normal,
      double fontSize = 12}) {
    return Container(
      width: 80,
      alignment: alignment,
      child: Text(
        string,
        style:
            GoogleFonts.montserrat(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
