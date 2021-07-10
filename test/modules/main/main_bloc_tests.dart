import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:sguvindex/modules/main/bloc/main_bloc.dart';
import 'package:http/testing.dart';
import 'package:sguvindex/modules/main/bloc/main_state.dart';
import 'package:sguvindex/modules/main/data/uv_data.dart';
import 'package:sguvindex/modules/main/data/uv_ui_data.dart';

void main() {
  late MainBloc mainBloc;
  late MockClient client;
  final jsonMock = '''
  {"items":[{"timestamp":"2021-07-04T16:00:00+08:00","update_timestamp":"2021-07-04T16:05:07+08:00","index":[{"value":4,"timestamp":"2021-07-04T15:00:00+08:00"},{"value":3,"timestamp":"2021-07-04T14:00:00+08:00"},{"value":2,"timestamp":"2021-07-04T13:00:00+08:00"}]}],"api_info":{"status":"healthy"}}
  ''';

  setUp(() {
    client = MockClient((request) async {
      final uvData = jsonMock;
      if (request.url.path != "/v1/environment/uv-index") {
        return Response("", 404);
      }
      return Response(uvData, 200,
          headers: {'content-type': 'application/json'});
    });
    mainBloc = MainBloc(httpClient: client);
  });

  test('initial state is correct', () {
    expect(MainBlocLoadingState(), mainBloc.state);
  });

  test('loadUVData action triggers an http call', () async {
    // Given
    final jsonString = jsonMock;
    Map<String, dynamic> decodedResponse = jsonDecode(jsonString);
    final uvData = UVData.fromJSON(decodedResponse);
    final uvUIData = uvData.items.first.records
        .map((record) => UVUIData.fromUVData(record))
        .toList();

    final state = MainBlocValidDataState(uvUIData);

    // When
    mainBloc.add(MainBlocEvent.loadUVData);

    // Then
    expectLater(mainBloc.stream, emitsInOrder([MainBlocLoadingState(), state]));
  });

  tearDown(() {
    mainBloc.close();
  });
}
