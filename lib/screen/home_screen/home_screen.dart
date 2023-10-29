import 'package:flutter/material.dart';
import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/data/service/api_service.dart';
import 'package:weather_app/screen/forecast_hours/hourly_weather_list_item.dart';
import 'package:weather_app/screen/future_forecast/future_forecast_list_item.dart';
import 'package:weather_app/screen/todays_weather/todays_weather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ApiService apiService=ApiService();
  final _textFieldController=TextEditingController();
  String _searchText= "auto:ip";

  _showTextInputDialog(BuildContext context)async{
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Search Location"),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(
              hintText: "search by city, zip, lat, long"
          ),
        ),actions: [
        ElevatedButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("Cancel")) ,
        ElevatedButton(onPressed: () {
          if(_textFieldController.text.isEmpty){
            return;
          }
          Navigator.pop(context, _textFieldController.text);

        }, child: Text("OK"))
      ],
      );
    },);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Weather App"),
        actions: [
          IconButton(onPressed: () async{
            _textFieldController.clear();
            String text=await _showTextInputDialog(context);
            setState(() {
              _searchText=text;
            });
          }, icon: Icon(Icons.search, color: Colors.white,)),
          IconButton(onPressed: () {
            _searchText= "auto:ip";
            setState(() {

            });
          }, icon: Icon(Icons.my_location, color: Colors.white,)),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: FutureBuilder(builder: (context, snapshot) {
        if(snapshot.hasData){
          WeatherModel? weatherModel=snapshot.data;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TodaysWeather(weatherModel: weatherModel,),
                  const SizedBox(height: 10,),
                  const Text("Weather by Hours",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: weatherModel?.forecast?.forecastday?[0].hour?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                        Hour? hour=weatherModel?.forecast?.forecastday?[0].hour?[index];
                        return HourlyWeatherListItem(hour: hour,);
                    },),
                  ),
                  const SizedBox(height: 10,),
                  const Text("Next 7 days weather",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Forecastday? forecastday=
                        weatherModel?.forecast?.forecastday?[index];
                        return FutureForecastListItem(
                          forecastday: forecastday,);
                    },
                      itemCount: weatherModel?.forecast?.forecastday?.length,

                    ),
                  ),
                ],
              ));
        }
        if(snapshot.hasError){
          return const Center(child: Text("Error has occured"),);
        }
        return const Center(child: CircularProgressIndicator(),);
      },
      future: apiService.getWeatherData(_searchText),
      )
    ),
    );
  }
}
