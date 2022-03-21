import 'dart:async';
//import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_joystick_view.dart';
import 'package:flutter/services.dart';
import 'package:controle_remoto/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
//import 'package:video_player/video_player.dart';

TextEditingController _url = TextEditingController();
String urlserver;

class Position {
  double degrees; //ângulo
  double r;       //raio

  Position(this.degrees, this.r);
}

Position globalPositionL = Position(0, 0), globalPositionR = Position(0, 0);




// void choiceAction(String choice) {
//   if (choice == Constants.Adjusts) {
//     print('Servidor de Imagem');
//   }
// }

//void main() => runApp(MyApp());

void main() {
  runApp(
    Phoenix(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  double degreel = 0, rl = 0, degreer = 0, rr = 0;
  double _currentSliderValue = 20;
  // TextEditingController _url = TextEditingController();
  // String urlserver, uRL;



  //double xcje = MediaQuery.of(context).size.width;
  //double width = MediaQuery. of(context). size. width;


  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (mounted) {    //https://media.tenor.com/images/eff22afc2220e9df92a7aa2f53948f9f/tenor.gif
      setState(() {
        globalPositionL.degrees = 0.0;
        globalPositionL.r = 0.0;
        globalPositionL.degrees = degreel;
        globalPositionL.r = rl;
        globalPositionR.degrees = 0.0;
        globalPositionR.r = 0.0;
        globalPositionR.degrees = degreer;
        globalPositionR.r = rr;
        print('globalPositionL: ${globalPositionL.degrees} ${globalPositionL.r}');
        print('globalPositionR: ${globalPositionR.degrees} ${globalPositionR.r}');
        print('urlserver: $urlserver');
        //print('uRL: $uRL');
      });
     // print('globalPositionL: ${globalPositionL.degrees} ${globalPositionL.r}');
     // print('globalPositionR: ${globalPositionR.degrees} ${globalPositionR.r}');
    }});
  }

  void choiceAction(String choice) {
    if (choice == Constants.Adjusts) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Column(
                children: <Widget> [
                  AlertDialog(
                      title: Text('Servidor de Imagem'),
                      content: //Padding(
                      //padding: const EdgeInsets.all(8.0),
                      Form(
                        child: TextFormField(
                          controller: _url,
                          //onChanged: (value) => urlserver = value,
                          decoration: InputDecoration(
                            labelText: 'URL do servidor',
                            //icon: Icons(Icons.link),
                          ),
                        ),
                      )
                  ),


                  ElevatedButton(
                      onPressed: () {
                        // ignore: unnecessary_statements
                        //_setText;
                        urlserver = _url.text;
                        Phoenix.rebirth(context);
                      },
                      child: Text('Enviar'))
                ]
            );
          }
      );

    }
  }

  // void _setText() {
  //   setState(() {
  //     uRL = urlserver.toString();
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // void _setText() {
    //   setState(() {
    //     urlserver = _url.text;
    //   });
    // }

    //@override

    //Variáveis de auxílio para tornar o aplicativo responsivo*
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    double xcje = w - (w*0.99);
    double ycje = h - (h*0.98);
    double xcjd = w - (w*0.99);
    double ycjd = h - (h*0.98);

    double sxe = xcje + (xcje*35);
   // double sye = h - (h*0.94);
   // double sxd = xcjd - 5;
    double syd = h - (h*0.94);
    //*

   // urlserver = _url.toString();


    return Scaffold(
      resizeToAvoidBottomInset : false,
      // appBar: AppBar(
      //   backgroundColor: Colors.red[800],
      //   title: Center(
      //       child: Text('Controle Remoto')
      //   ),
      //   actions: <Widget> [
      //        PopupMenuButton<String>(
      //         onSelected: choiceAction,
      //         itemBuilder: (BuildContext context){
      //            return Constants.choices.map((String choice){
      //              return PopupMenuItem<String>(
      //               value: choice,
      //                child: Text(choice),
      //              );
      //            }).toList();
      //          },
      //        )
      //    ],
      // ),

      body: Stack(      //Stack para widgets sobrepostos
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: WebView(
                  initialUrl: '$urlserver',
                  javascriptMode: JavascriptMode.unrestricted,
                )
              ),


                  Positioned(
                    left: xcje,
                    bottom: ycje,
                    width: w * 0.2,
                    height: h * 0.45,
                  child: Column(
                      children: [


                      Text(
                          'Braço: ${globalPositionL.degrees.toStringAsFixed(0)} ${globalPositionL.r.toStringAsFixed(0)}\n',
                          style: TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                      ),
                    Container(
                      //color: Colors.orange,
                      child:  JoystickView(
                      opacity: 0.5,
                      size: w*0.19,
                      onDirectionChanged: (double degrees, double distanceFromCenter) {
                        //double radians = degrees * pi / 180;
                        //x = sin(radians) * distanceFromCenter;
                        degreel = degrees;
                        //y = cos(radians) * distanceFromCenter;
                        rl = distanceFromCenter * 100;
                       // print('changed direction, degrees: $degreel r: $rl');
                      },
                    )



                    ),
                ]
                  ),
                  ),
              Positioned(
                  left: sxe,
                  //right: sxd,
                  bottom: syd,
              child: Container(
               // color: Colors.amber,
                width: w * 0.3,
                 child: Column(
                      children:
                              [
                  //Text('globalPositionL: ${globalPositionL.degrees} ${globalPositionL.r}\n globalPositionR: '
                  //    '${globalPositionR.degrees} ${globalPositionR.r}'),
                  Text(
                    'Garra',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),

                  Slider(
                      activeColor: Colors.blueGrey,
                      value: _currentSliderValue,
                      min: 0,
                      max: 255,
                      divisions: 255,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        }
                        );
                      }
                  )
                  ]
                  ),
                  ),
              ),

              Positioned(
                  right: xcjd,
                  bottom: ycjd,
                  width: w * 0.2,
                  height: h * 0.45,
              child: Column(
                  children: [

                    Text(
                      'Move: ${globalPositionR.degrees.toStringAsFixed(0)} ${globalPositionR.r.toStringAsFixed(0)}\n',
                      style: TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  Container(
              //  color: Colors.orange,
                  child: JoystickView(
                      opacity: 0.5,
                        size: w * 0.19,
                        onDirectionChanged: (double degrees, double distanceFromCenter) {
                          //double radians = degrees * pi / 180;
                          //x = sin(radians) * distanceFromCenter;
                          degreer = degrees;
                          //y = cos(radians) * distanceFromCenter;
                          rr = distanceFromCenter * 100;
                        //  print('changed direction, degrees: $degreer r: $rr');
                        },
                      ),

                  )
                ]
              )
               )
            ],
          ),


      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.red,
      //
      //
      //   onPressed: () {
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //               title: Text('Servidor de Imagem'),
      //               content: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Form(
      //                     child: TextField(
      //                       controller: _formKey,
      //                         //icon: Icons(Icons.link),
      //                       ),
      //                     ),
      //                   )
      //           );
      //         }
      //     );
      //   },
      //
      //   child: Icon(Icons.add_link),
      //   tooltip: 'Adicionar link do servidor!'
      // ),
      // floatingActionButtonLocation:
      //       FloatingActionButtonLocation.endTop,
      );

    }

}
