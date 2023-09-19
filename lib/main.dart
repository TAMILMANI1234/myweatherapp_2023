import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var URL ="http://api.weatherapi.com/v1/current.json?key=8868e7d431964dd89a265801230604&q=Erode&aqi=no";

  var city;
  var state;
  var country;
  var temperature;
  var weather_report;
  var humidity;
  var windspeed;
  Future getweather() async{
    http.Response response =await http.get(Uri.parse(URL));
    var result =jsonDecode(response.body);

    setState(() {
      this.city =result['location']['name'];
      this.state=result['location']['region'];
      this.country=result['location']['country'];
      this.temperature=result['current']['temp_c'];
      this.weather_report=result['current']['condition']['text'];
      this.humidity=result['current']['humidity'];
      this.windspeed=result['current']['wind_kph'];

    });
  }

  @override
  void initState(){
    super.initState();
    this.getweather();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My weather Application"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            decoration:  new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("sky1.jpg"),fit: BoxFit.cover)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                        this.city.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                ),
                Padding(
                    padding:EdgeInsets.only(bottom: 20),
                  child: Text(
                      this.state.toString() + ","+ this.country.toString(),
                    style:  TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                    ),
                  ),
                ),

              ],
            ),

          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(

                  children: [
                    ListTile(
                      leading: Image.asset("temperature.jpg"),
                      title: Text("Temperature"),
                      trailing: Text(this.temperature.toString()+"\u00B0C",style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Image.asset("weather.jpg",height: 30,),
                      title: Text("Weather"),
                      trailing: Text(this.weather_report.toString(),style: TextStyle(fontWeight: FontWeight.w500) ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Image.asset("humidity.png"),
                      title: Text("Humidity"),
                      trailing: Text(this.humidity.toString()+"%",style: TextStyle(fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Image.asset("wind.png"),
                      title: Text("Wind Speed"),
                      trailing: Text(this.windspeed.toString()+"kph",style: TextStyle(fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}
