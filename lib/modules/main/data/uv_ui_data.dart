import 'package:sguvindex/modules/main/data/uv_data.dart';
import 'package:intl/intl.dart';
import 'package:sguvindex/modules/main/data/uv_index.dart';

class UVUIData {
  const UVUIData(
      {required this.date, required this.uvValue, required this.uvDescription});

  factory UVUIData.fromUVData(UVDataRecord record) {
    final dateValue = record.timestamp.add(const Duration(hours: 8));
    final uvIndex = UVIndex.fromValue(record.value);

    return UVUIData(
        date: DateFormat.jm().format(dateValue),
        uvValue: record.value.toString(),
        uvDescription: uvIndex.name());
  }

  final String date;
  final String uvValue;
  final String uvDescription;
}
