import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sguvindex/modules/main/data/uv_data.dart';
import 'package:sguvindex/modules/main/data/uv_ui_data.dart';

import 'main_state.dart';

enum MainBlocEvent { loadUVData }

class MainBloc extends Bloc<MainBlocEvent, MainBlocState> {
  MainBloc({required this.httpClient}):
    super(const MainBlocLoadingState());

  final http.Client httpClient;

  @override
  Stream<MainBlocState> mapEventToState(MainBlocEvent event) async* {
    switch (event) {
      case MainBlocEvent.loadUVData:
        yield* _processLoading();
    }
  }

  Stream<MainBlocState> _processLoading() async* {
    yield MainBlocLoadingState();

    try {
      final uvData = await _fetchUVData();
      final uvUIData = uvData.items.first.records.map(
        (record) => UVUIData.fromUVData(record)
      ).toList();
      yield MainBlocValidDateState(uvUIData);
    } catch(exception) {
      yield MainBlocErrorState(exception.toString());
    }
  }

  Future<UVData> _fetchUVData() async {
    final response = await httpClient.get(
      Uri.https(
        'api.data.gov.sg',
        '/v1/environment/uv-index',
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      return UVData.fromJSON(decodedResponse);
    }
    throw Exception('error fetching posts');
  }

}