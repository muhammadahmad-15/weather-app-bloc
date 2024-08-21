import 'package:weather_app/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_bloc/weather_state.dart';
import 'package:weather_app/data/repository/weather_repo.dart';
import 'package:bloc/bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;
  WeatherBloc({required this.weatherRepo}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherIsLoading());
    try {
      if (event.latitude <= 0.0 || event.longitude <= 0.0) {
        emit(const WeatherError(
            'Please enter valid numerical values for latitude and longitude.'));
        return;
      }
      final weather =
          await weatherRepo.fetchWeather(event.latitude, event.longitude);
      emit(WeatherIsLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
