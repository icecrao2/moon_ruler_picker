

## Description
this package provide you with good ruler picker! <br/>
Experience the Ruler Picker smoothly gliding through a swift swipe motion, coming to a natural halt! <br/>
Customize the movement of the Ruler Picker by setting acceleration and resistance to achieve your desired behavior. <br/>

![gif.gif](gif.gif)

## Getting started

```
flutter pub add moon_ruler_picker
```

## Usage

``` dart
   RulerPicker(
      width: 300,
      height: 200,
      resistance: 1,
      acceleration: 1,
      linesType: MoonRulerLinesType.lineWithLabel,
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
      selectedNumber: _doubleData,
      borderWidth: 2,
      pickedBarColor: const Color(0XFF0180BE),
      barColor: const Color(0XFF0180BE).withOpacity(0.3)
    ),
```
