import 'package:flutter/material.dart';

class todayWeatherWidget extends StatefulWidget {
  // const todayWeatherWidget({super.key});

  @override
  State<todayWeatherWidget> createState() => _todayWeatherWidgetState();
}

class _todayWeatherWidgetState extends State<todayWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Today's weather"),
             backgroundColor: Colors.blueAccent.withOpacity(0.5),
          ),
          body: Container(
             color: Colors.redAccent,
             child: Stack( 
                 children: [
                     Image.asset("assets/images/dark.jpg"),
                     Container( 
                        width: double.infinity,
                        color: Color.fromARGB(100, 22, 44, 33),
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(40),
                        child: Text("Today's weather",
                             style: TextStyle(fontSize: 25, color: Colors.white),),
                     ),
                 ],
             ),
          )
       );
  }
}
