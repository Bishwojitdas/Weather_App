import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/model/weather_model.dart';

class FutureForecastListItem extends StatelessWidget {
  final Forecastday? forecastday;
  const FutureForecastListItem({Key? key, this.forecastday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Image.network("http:${forecastday?.day?.condition?.icon ??""}"),
          
          Expanded(
            child: Text(DateFormat.MMMEd().format(DateTime.parse(forecastday?.date?.toString()??"")),
              style:const TextStyle(color: Colors.white) ,),
          ),

          Expanded(
            child: Text(forecastday?.day?.condition?.text?.toString() ??"",
              style:const TextStyle(color: Colors.white) ,),
          ),
          Expanded(
                child: Text("^${forecastday?.day?.maxtempC?.round().toString() ??""}/"
                    "${forecastday?.day?.mintempC?.round().toString() ??""}",
                  style:const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500) ,),
              ),

        ],
      ),
    );
  }
}
