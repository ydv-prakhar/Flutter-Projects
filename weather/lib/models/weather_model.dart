class Weather{
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String,dynamic>json){
    print(json['location']['name']);
    print(json['current']['temp_c']);
    print(json['current']['condition']['text']);
    return Weather(cityName: 'Indore', 
    temperature: 5,
    mainCondition:'cloudy',
    );
  }

}