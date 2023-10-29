import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/model/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;
  const TodaysWeather({Key? key, this.weatherModel}) : super(key: key);

  WeatherType getWeatherType(Current? current){
    if(current?.isDay==1){
      if(current?.condition?.text=="Sunny"){
        return WeatherType.sunny;
      }else  if(current?.condition?.text=="OverCast"){
        return WeatherType.overcast;
      }else  if(current?.condition?.text=="Partly Cloudy"){
        return WeatherType.cloudy;
      }else  if(current?.condition?.text=="Cloudy"){
        return WeatherType.cloudy;
      }else  if(current?.condition?.text=="Mist"){
        return WeatherType.lightSnow;
      }else  if(current!.condition!.text!.contains("thunder")){
        return WeatherType.thunder;
      }else  if(current!.condition!.text!.contains("rain")){
        return WeatherType.heavyRainy;
      }else  if(current!.condition!.text!.contains("showers")){
        return WeatherType.middleSnow;
      }else  if(current!.condition!.text!.contains("clear")){
        return WeatherType.sunny;
      }
    }else{
      if(current?.condition?.text=="Sunny"){
        return WeatherType.sunny;
      }else  if(current?.condition?.text=="OverCast"){
        return WeatherType.overcast;
      }else  if(current?.condition?.text=="Partly Cloudy"){
        return WeatherType.cloudyNight;
      }else  if(current?.condition?.text=="Cloudy"){
        return WeatherType.cloudyNight;
      }else  if(current?.condition?.text=="Mist"){
        return WeatherType.lightSnow;
      }else  if(current!.condition!.text!.contains("thunder")){
        return WeatherType.thunder;
      }else  if(current!.condition!.text!.contains("rain")){
        return WeatherType.heavyRainy;
      }else  if(current!.condition!.text!.contains("showers")){
        return WeatherType.middleSnow;
      }else  if(current!.condition!.text!.contains("clear")){
        return WeatherType.sunnyNight;
      }
    }

    return WeatherType.thunder;
  }


  @override
  Widget build(BuildContext context) {
     var FullWidth=MediaQuery.of(context).size.width;
     var FullHeight=MediaQuery.of(context).size.height;

    return Stack(
      children: [
        WeatherBg(
            weatherType: getWeatherType(weatherModel?.current),
            width: double.infinity,
            height: 300),

        SizedBox(
          width: FullWidth,
          height: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Text(
                      weatherModel?.location?.name?? "", style:const TextStyle(fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                    Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.parse(weatherModel?.current?.lastUpdated.toString()??"")),
                      style:const TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10,),
                  Container(
                    padding:const EdgeInsets.all(2),
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10
                      ),
                      child: Image.network("https:${weatherModel?.current?.condition?.icon??""}")),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${weatherModel?.current?.tempC?.round().toString()??""}°",
                        style:const TextStyle(
                        color: Colors.pink,fontSize: 70, fontWeight: FontWeight.bold
                      ),),
                      Text(weatherModel?.current?.condition?.text.toString()??"",
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                  SizedBox(width: 10,),


                ],
              ),
             const SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                        const  Text("Feels Like", style: TextStyle(
                              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300
                          ),),
                          Text("${weatherModel?.current?.feelslikeC?.round().toString()??""}°", style:const TextStyle(
                              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      Column(
                        children: [
                          const  Text("Wind", style: TextStyle(
                              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300
                          ),),
                          Text("${weatherModel?.current?.windKph?.round().toString()??""} km/h", style:const TextStyle(
                              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                        const  Text("Humidity", style: TextStyle(
                              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300
                          ),),
                          Text("${weatherModel?.current?.humidity?.round().toString()??""}%", style:const TextStyle(
                              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      Column(
                        children: [
                          const  Text("Visibility", style: TextStyle(
                              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300
                          ),),
                          Text("${weatherModel?.current?.visKm?.round().toString()??""} km", style:const TextStyle(
                              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              )
            ],
          ),
        )

      ],
    );
  }
}
