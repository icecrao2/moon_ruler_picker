

part of ruler_picker_lib;



class RulerPicker extends StatefulWidget {

  double selectedNumber;
  Function(double) callbackDouble;
  Function(int)? callbackInt;
  int? maxNumber;
  int? minNumber;

  double resistance;
  double acceleration;

  double width;
  double height;
  double borderWidth;
  Color pickedBarColor;
  Color barColor;

  RulerPicker({
    super.key,
    required this.callbackDouble,
    this.callbackInt,
    required this.selectedNumber,
    required this.width,
    required this.height,
    required this.borderWidth,
    required this.pickedBarColor,
    required this.barColor,
    this.resistance = 1,
    this.acceleration = 1,
    this.maxNumber,
    this.minNumber,
  });

  @override
  State<StatefulWidget> createState() => _RulerPickerState(selectedNumber: selectedNumber);
}

class _RulerPickerState extends State<RulerPicker> {

  double get resistance => 0.99 / widget.resistance;
  double get acceleration => 0.0002 * widget.acceleration;

  Timer? timer;
  double selectedNumber;
  int prev;

  int? get maxNumber => widget.maxNumber;
  int? get minNumber => widget.minNumber;
  double get height => widget.height;
  double get borderWidth => widget.borderWidth;
  Color get pickedBarColor => widget.pickedBarColor;
  Color get barColor => widget.barColor;

  _RulerPickerState({required this.selectedNumber})
    :prev = selectedNumber.floor();

  @override
  void didUpdateWidget(covariant RulerPicker oldWidget) {
    selectedNumber = widget.selectedNumber;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> rulerLines = [];

    for (int index = 0; index < 20; index++) {
      if (maxNumber == null) {
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: selectedNumber + index, width: borderWidth, height: height, color: barColor, pickedColor: pickedBarColor));
      } else if( (selectedNumber + index) >= maxNumber! ) {
        double maxDouble = maxNumber!.toDouble();
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: maxDouble, width: borderWidth, height: height, color: barColor, pickedColor: pickedBarColor));
        break;
      } else {
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: selectedNumber + index, width: borderWidth, height: height, color: barColor, pickedColor: pickedBarColor));
      }
    }

    for (int index = -1; index > -20; index--) {
      if (minNumber == null) {
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: selectedNumber + index, width: borderWidth, height: height, color: barColor, pickedColor: pickedBarColor));
      } else if( (selectedNumber + index) < minNumber! ) {
        double minDouble = minNumber!.toDouble();
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: minDouble, width: borderWidth, height: height, color: barColor, pickedColor: pickedBarColor));
        break;
      } else {
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: selectedNumber + index, width: borderWidth, height: height, color: barColor, pickedColor: pickedBarColor));
      }
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragDown: (details) {
          timer?.cancel();
          timer = null;
        },
        onHorizontalDragEnd: (details) {
          shootDrag(details);
        },
        onHorizontalDragUpdate: (details) {
          updateDrag(details);
        },
        child: SizedBox(
          width: double.infinity,
          child: Stack(
              alignment: Alignment.center,
              children: rulerLines
          ),
        ),
      ),
    );
  }

  void updateDrag(details) {
    setState(() {
      double delta = details.delta.dx;

      _moveRulerPicker(delta);
      _limitMaxNumber();
      _limitMinNumber();
    });

    _vibratingOnIntegerValue();

    widget.callbackDouble(selectedNumber);
    widget.callbackInt == null ? null : widget.callbackInt!(selectedNumber.floor());
  }

  void shootDrag(details) {

    double velocity = (details.primaryVelocity ?? 0) * acceleration;

    timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      velocity = velocity * resistance;
      setState(() {
        selectedNumber -= (velocity);
        _limitMaxNumber();
        _limitMinNumber();

        widget.callbackDouble(selectedNumber);
        widget.callbackInt == null ? null : widget.callbackInt!(selectedNumber.floor());
      });

      _vibratingOnIntegerValue();

      if (velocity.abs() < 0.1) {
        this.timer?.cancel();
        this.timer = null;
      }
    });
  }


  void _moveRulerPicker(double delta) {
    if (delta > 5) {
      selectedNumber -= 5 * 0.2;
    } else if (delta < -5) {
      selectedNumber -= -5 * 0.2;
    } else {
      selectedNumber -= delta * 0.2;
    }
  }

  void _limitMaxNumber() {
    if (maxNumber == null) {

    } else if( (selectedNumber) >= maxNumber! ) {
      selectedNumber =  maxNumber!.toDouble();
    }
  }

  void _limitMinNumber() {
    if (minNumber == null) {

    } else if( (selectedNumber) <= minNumber! ) {
      selectedNumber =  minNumber!.toDouble();
    }
  }

  void _vibratingOnIntegerValue() {
    if ((selectedNumber.floor() - prev).abs() >= 0.5) {
      HapticFeedback.selectionClick();
      prev = selectedNumber.floor();
    }
  }
}

