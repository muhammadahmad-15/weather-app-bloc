// lib/presentation/screens/weather_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/weather_bloc/weather_bloc.dart';
import '../../bloc/weather_bloc/weather_event.dart';
import '../../bloc/weather_bloc/weather_state.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _latitudeController,
              decoration: const InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _longitudeController,
              decoration: const InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_latitudeController.text.isNotEmpty &&
                    _longitudeController.text.isNotEmpty) {
                  final double latitude =
                      double.parse(_latitudeController.text);
                  final double longitude =
                      double.parse(_longitudeController.text);
                  context.read<WeatherBloc>().add(
                      FetchWeather(latitude: latitude, longitude: longitude));
                }
              },
              child: const Text('Fetch Weather'),
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherIsLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherIsLoaded) {
                  return Text(
                      'Temperature: ${state.weather.current?.temperature2m ?? 0}°C');
                } else if (state is WeatherError) {
                  return Text('Error: ${state.message}');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
