import 'package:equatable/equatable.dart';
import 'package:sguvindex/modules/main/data/uv_ui_data.dart';

abstract class MainBlocState extends Equatable {
  final String statusMessage = '';
  const MainBlocState();
}

class MainBlocLoadingState extends MainBlocState {
  final String statusMessage = 'MainBlocLoadingState';

  const MainBlocLoadingState();

  @override
  List<Object> get props => [statusMessage];
}

class MainBlocValidDateState extends MainBlocState {
  final String statusMessage = 'MainBlocValidDateState';
  final List<UVUIData> data;

  const MainBlocValidDateState(this.data);

  @override
  List<Object> get props => [statusMessage];
}

class MainBlocErrorState extends MainBlocState {
  final String statusMessage = 'MainBlocErrorState';
  final String errorMessage;

  const MainBlocErrorState(String errorMessage): 
    this.errorMessage = errorMessage;

  @override
  List<Object> get props => [statusMessage, errorMessage];
}