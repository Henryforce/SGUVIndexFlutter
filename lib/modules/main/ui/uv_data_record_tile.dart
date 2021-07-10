import 'package:flutter/material.dart';
import 'package:sguvindex/modules/main/data/uv_ui_data.dart';

class UVDataRecordTile extends StatelessWidget {
  const UVDataRecordTile({Key? key, required this.record}) : super(key: key);

  final UVUIData record;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(record.uvValue),
        isThreeLine: true,
        subtitle: Text(record.date),
        dense: true,
      ),
    );
  }
}
