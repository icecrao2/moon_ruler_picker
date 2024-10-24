

import 'package:flutter/material.dart';
import 'package:moon_ruler_picker/ruler_picker_lib.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  double _doubleData = 0;
  int _intData = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Form(
              child: TextFormField(
                controller: TextEditingController(text: _doubleData.toStringAsFixed(2)),
                key: UniqueKey(),
                onChanged: (data) {
                  _doubleData = double.tryParse(data) ?? 0;
                  _intData = _doubleData.floor();
                },
                onEditingComplete: () {
                  setState(() {});
                },
              ),
            ),

            Form(
              child: TextFormField(
                controller: TextEditingController(text: _intData.toString()),
                key: UniqueKey(),
                onChanged: (data) {
                  _doubleData = double.tryParse(data) ?? 0;
                  _intData = _doubleData.floor();
                },
                onEditingComplete: () {
                  setState(() {});
                },
              ),
            ),

            SizedBox(
              width: 400,
              height: 200,
              child: RulerPicker(
                  height: 200,
                  minNumber: 0,
                  maxNumber: 100,
                  longVerticalLineHeightRatio: 0.9,
                  shortVerticalLineHeightRatio: 0.8,
                  selectedVerticalLineHeightRatio: 1.2,
                  resistance: 1,
                  acceleration: 1,
                  linesType: MoonRulerLinesType.circularLine,
                  callbackDouble: (data) {
                    setState(() {
                      _doubleData = data;
                    });
                  },
                  callbackInt: (data) {
                    setState(() {
                      _intData = data;
                    });
                  },
                  initNumber: _doubleData,
                  borderWidth: 1,
                  pickedBarColor: const Color(0XFF0180BE),
                  barColor: const Color(0XFF0180BE).withOpacity(0.3)
              ),
            ),

            const Spacer(),

          ],
        ),
      ),

    );
  }
}
