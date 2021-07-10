import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sguvindex/modules/main/bloc/main_bloc.dart';
import 'package:sguvindex/modules/main/bloc/main_state.dart';
import 'package:http/http.dart' as http;
import 'package:sguvindex/modules/main/data/uv_ui_data.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainBloc(
          httpClient: http.Client()
        )..add(MainBlocEvent.loadUVData),
      child: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<MainBloc, MainBlocState>(
          builder: (context, state) {
            return _buildFromState(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildFromState(BuildContext context, MainBlocState state) {
    final textTheme = Theme.of(context).textTheme;

    if (state is MainBlocValidDateState) {
      return _buildValidData(state);
    } else if (state is MainBlocErrorState) {
      return Text('${state.errorMessage}', style: textTheme.headline2);
    } else {
      return Text('$state', style: textTheme.headline2);
    }
  }

  Widget _buildValidData(MainBlocValidDateState state) {
    if (state.data.isEmpty) {
      return const Center(child: Text('No records available at the moment'));
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return UVDataRecordTile(record: state.data[index]);
      },
      itemCount: state.data.length,
      controller: _scrollController,
    );
  }
}

class UVDataRecordTile extends StatelessWidget {
  const UVDataRecordTile({Key? key, required this.record}) : super(key: key);

  final UVUIData record;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        // leading: Text('${post.id}', style: textTheme.caption),
        title: Text(record.uvValue),
        isThreeLine: true,
        subtitle: Text(record.date),
        dense: true,
      ),
    );
  }
}