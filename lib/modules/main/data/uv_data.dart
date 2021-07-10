import 'package:equatable/equatable.dart';

class UVData extends Equatable {
  const UVData({required this.items, required this.apiInfo});

  factory UVData.fromJSON(Map<String, dynamic> json) {
    final items = json['items'] as List;
    final uvItems = items.map((item) => UVItem.fromJsonMap(item)).toList();
    return UVData(items: uvItems, apiInfo: APIInfo.fromJSON(json['api_info']));
  }

  final List<UVItem> items;
  final APIInfo apiInfo;

  @override
  List<Object?> get props => [items, apiInfo];
}

class APIInfo extends Equatable {
  const APIInfo({required this.status});

  APIInfo.fromJSON(Map<String, dynamic> json) : status = json['status'];

  final String status;

  @override
  List<Object?> get props => [status];
}

class UVItem extends Equatable {
  const UVItem(
      {required this.timestamp,
      required this.updateTimestamp,
      required this.records});

  factory UVItem.fromJsonMap(Map<String, dynamic> json) {
    final records = json['index'] as List;
    final uvDataRecords =
        records.map((record) => UVDataRecord.fromJson(record)).toList();
    return UVItem(
        timestamp: DateTime.parse(json['timestamp']),
        updateTimestamp: DateTime.parse(json['update_timestamp']),
        records: uvDataRecords);
  }

  final DateTime timestamp;
  final DateTime updateTimestamp;
  final List<UVDataRecord> records;

  @override
  List<Object?> get props => [timestamp, updateTimestamp, records];
}

class UVDataRecord extends Equatable {
  const UVDataRecord({required this.value, required this.timestamp});

  UVDataRecord.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        timestamp = DateTime.parse(json['timestamp']);

  final int value;
  final DateTime timestamp;

  @override
  List<Object?> get props => [value, timestamp];
}
