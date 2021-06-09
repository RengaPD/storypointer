import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story Pointer',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: 'Jost',
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Story Pointer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


   String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const ticks = [0, 1, 2, 3, 3, 4, 5, 6];
  var features = ["Complexity", "Remoteness", "Interaction", "Risk", "Dimension"];
  var data = [
    [1,0,0,1,1],
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.amber)),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            PopupMenuButton(
                child: Icon(Icons.info_outline),
                itemBuilder: (context){
            return List.generate(1, (index){return PopupMenuItem(child: Text("Complexity, Dimension and Risk have minimum value: 1"));});
            }
            ),
            Container(
              height: 300,
              child: RadarChart(
                ticks: ticks,
                features: features,
                data: data,
                reverseAxis: false,
                ticksTextStyle: TextStyle(color: Colors.grey, fontFamily: 'Jost',fontSize: 12),
                featuresTextStyle: TextStyle(color: Colors.grey, fontFamily: 'Jost', fontSize: 14),
                outlineColor: Colors.blueGrey,
                  graphColors: [Colors.amber],
                  sides: features.length
              ),
            ),
            Center(child: Text("Complexity",style: TextStyle(color: Colors.amber))),
            Slider(value: data[0][0].roundToDouble(),
                min: 1,
                max: 6,
                label: data[0][0].toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.blueGrey,
                divisions: 5,
                onChanged: (double value) {setState(() {
                  data[0][0] = value.toInt();
                  widget.title = riscriviTitolo(data[0]);
                });}
                  ),
            Center(child: Text("Remoteness",style: TextStyle(color: Colors.amber))),
            Slider(value: data[0][1].roundToDouble(),
                min: 0,
                max: 5,
                label: data[0][1].toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.blueGrey,
                divisions: 5,
                onChanged: (double value) {setState(() {
                  data[0][1] = value.toInt();
                  widget.title = riscriviTitolo(data[0]);
                });}
            ),
            Center(child: Text("Interaction",style: TextStyle(color: Colors.amber))),
            Slider(value: data[0][2].roundToDouble(),
                min: 0,
                max: 5,
                label: data[0][2].toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.blueGrey,
                divisions: 5,
                onChanged: (double value) {setState(() {
                  data[0][2] = value.toInt();
                  widget.title = riscriviTitolo(data[0]);
                });}
            ),
            Center(child: Text("Risk",style: TextStyle(color: Colors.amber))),
            Slider(value: data[0][3].roundToDouble(),
                min: 1,
                max:6,
                label: data[0][3].toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.blueGrey,
                divisions: 5,
                onChanged: (double value) {setState(() {
                  data[0][3] = value.toInt();
                  widget.title = riscriviTitolo(data[0]);
                });}
            ),
            Center(child: Text("Dimension",style: TextStyle(color: Colors.amber))),
            Slider(value: data[0][4].roundToDouble(),
                min: 1,
                max: 6,
                label: data[0][4].toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.blueGrey,
                divisions: 5,
                onChanged: (double value) {setState(() {
                  data[0][4] = value.toInt();
                  widget.title = riscriviTitolo(data[0]);
                });}
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              child: Center(child: Text("Credits: File.ini"),),
            )
          ],

    )
    );
  }

  String riscriviTitolo(List<int> data) {
    double area = calcolaArea(data);
    int areanormalizzata = (area*0.8).toInt();
    int storypoints = fibonacciatore(areanormalizzata);
    String maglietta = magliettatore(storypoints);

    return "Story Pointer: "+ storypoints.toString()+", T-Shirt Size: "+ maglietta;
  }

  double calcolaArea(List<int> data) {

    double area = 0;

    for( var i = 0 ; i < data.length ; i++ ) {
      if (data[i] != 0){
        for( var j = 0 ; j < data.length ; j++ ) {
          if (i<(data.length-(j+1)) && data[i+(j+1)]!=0){
            area += calcolaareatriangoloconangoloevalore(i,j+1,data).abs();
          }
        }
      }
    }
    return area;

  }

  num calcolaareatriangoloconangoloevalore(int start,int angles, List<int> data) {
    return data[start]*data[start+angles]*sin((2*pi/data.length)*angles)/2;
  }

  int fibonacciatore(int areanormalizzata) {

    var fibonacci = [1,2,3,5,8,13,21,40,100];
    var choosenone = fibonacci[0];

    for( var i = 0 ; i < (fibonacci.length-1) ; i++ ) {
      if(fibonacci[i]<=areanormalizzata && areanormalizzata<=fibonacci[i+1]) {
        choosenone = fibonacci[i+1];
      }
    }
    return choosenone;
    }

  String magliettatore(int storypoints) {
    String maglietta = "S";
    if(storypoints> 8){maglietta="M";}
    if(storypoints> 20){maglietta="L";}
    if(storypoints> 40){maglietta="XL";}
    if(storypoints== 100){maglietta="XXL";}
    return maglietta;
  }
}


