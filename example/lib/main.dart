

import 'package:flutter/material.dart';
import 'package:ruler_picker_lib/ruler_picker/ruler_picker.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'moon ruler-picker'),
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

  double _data = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text('$_data'),

            SizedBox(
              width: 300,
              height: 100,
              child: RulerPicker(
                  callback: (data) {
                    setState(() {
                      _data = data;
                    });
                  },
                  selectedNumber: _data,
                  height: 50,
                  borderWidth: 2,
                  pickedColor: const Color(0XFF0180BE),
                  color: const Color(0XFF0180BE).withOpacity(0.3)
              ),
            )


          ],
        ),
      ),

    );
  }
}