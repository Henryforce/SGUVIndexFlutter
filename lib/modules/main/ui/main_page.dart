import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sguvindex/modules/main/bloc/main_bloc.dart';
import 'package:sguvindex/modules/main/bloc/main_state.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sguvindex/modules/main/ui/uv_data_record_tile.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MainBloc(httpClient: http.Client())..add(MainBlocEvent.loadUVData),
      child: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  final _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('SGUVIndex')),
      appBar: AppBar(
        title: _buildHeader(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: BlocBuilder<MainBloc, MainBlocState>(
          builder: (context, state) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              child: _buildFromState(context, state),
              onRefresh: () async {
                BlocProvider.of<MainBloc>(context)
                    .add(MainBlocEvent.loadUVData);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFromState(BuildContext context, MainBlocState state) {
    final textTheme = Theme.of(context).textTheme;

    if (state is MainBlocValidDataState) {
      _refreshController.refreshCompleted();
      return _buildValidData(state);
    } else if (state is MainBlocErrorState) {
      return Text('${state.errorMessage}', style: textTheme.headline2);
    } else {
      return Text('$state', style: textTheme.headline2);
    }
  }

  Widget _buildValidData(MainBlocValidDataState state) {
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

  Widget _buildHeader() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      children: [
        Column(
          children: [
            Text(
              'Singapore',
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            Text(
              'UV Levels',
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 24),
            )
          ],
        ),
        Column(
          children: [
            Text(
              DateFormat.MMM().format(_singaporeTimeNow()),
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
            ),
            Text(
              DateFormat.d().format(_singaporeTimeNow()),
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )
          ],
        ),
      ],
    );
  }

  DateTime _singaporeTimeNow() {
    return DateTime.now().toUtc().add(const Duration(hours: 8));
  }
}
