import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/repositories/weather_repostory.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final WeatherRepostory weatherRepository;

  SearchBloc(this.weatherRepository) : super(SearchInitial()) {
    on<SearchWeather>(_onSearchWeather);
    on<ResetSearch>(_onResetSearch);
  }

  Future<void> _onSearchWeather(
    SearchWeather event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    try {
      final weather = await weatherRepository.searchWeatherByLocation(
        city: event.query,
      );
      emit(SearchSuccess(weather));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }

  void _onResetSearch(ResetSearch event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }
}
