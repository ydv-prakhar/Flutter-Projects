import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

import 'package:weather/models/weather_model.dart';

class WeatherService{
  static const BASE_URL = 'http://api.weatherapi.com/v1/current.json';
  final String apiKey ;

  WeatherService({
    required this.apiKey,
  });

  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?key=$apiKey&q=$cityName&aqi=no'));

    if(response.statusCode == 200){
      return Weather.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return "Indore";


    // List<Placemark> placemarks =
    //       await placemarkFromCoordinates(22.7227162, 75.8246141);
    //     // await placemarkFromCoordinates(position.latitude, position.longitude);

    // String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;
    // print("******************************* $city");
    // return city ?? "";
  } catch (e) {
    print("Error getting current city: $e");
    return ""; // or throw an error here based on your app's requirements
  }
}


}