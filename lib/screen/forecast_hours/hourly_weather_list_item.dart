import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/model/weather_model.dart';

class HourlyWeatherListItem extends StatelessWidget {
  final Hour? hour;
  const HourlyWeatherListItem({Key? key, this.hour,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white24
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("${hour?.tempC?.round().toString()??""}°", style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold
          ),),
          Container(
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal
            ),
            child: Image.network("http:${hour?.condition?.icon?.toString()??""}"),
          ),
          Text(DateFormat.j().format(DateTime.parse(hour?.time?.toString()??"")),style: TextStyle(
            color: Colors.white, fontSize: 15,
          ),)
        ],
      ),
    );
  }
}
