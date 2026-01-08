part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchWeather extends SearchEvent {
  final String query;
  SearchWeather(this.query);
}

final class ResetSearch extends SearchEvent {}
