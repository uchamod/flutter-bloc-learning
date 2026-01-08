part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final WeatherModel weatherModel;
  SearchSuccess(this.weatherModel);
}

final class SearchFailure extends SearchState {
  final String error;
  SearchFailure(this.error);
}
