import 'package:sguvindex/modules/main/data/uv_data.dart';

class UVUIData {
  const UVUIData(
      {required this.date, required this.uvValue, required this.uvDescription});

  factory UVUIData.fromUVData(UVDataRecord record) {
    return UVUIData(
        date: record.timestamp.toString(),
        uvValue: record.value.toString(),
        uvDescription: '');
  }

  final String date;
  final String uvValue;
  final String uvDescription;
}
