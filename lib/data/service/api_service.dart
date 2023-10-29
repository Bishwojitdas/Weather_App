import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/utills/app_constants.dart';

class ApiService{
  Future<WeatherModel> getWeatherData(String searchText)async{

    String url="$baseUrl&q=$searchText&days=7";
    try{
      Response response=await get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String,dynamic>json=jsonDecode(response.body);
        WeatherModel weatherModel=WeatherModel.fromJson(json);
        return weatherModel;
      }else{
        throw "No data found";
      }
    }catch(e){
      print(e.toString());
      throw e.toString();
    }
  }
}