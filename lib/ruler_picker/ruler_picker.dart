

part of ruler_picker_lib;



class RulerPicker extends LeafRenderObjectWidget {

  final MoonRulerLinesType linesType;

  final double initNumber;
  final Function(double) callbackDouble;
  final Function(int)? callbackInt;
  final int maxNumber;
  final int minNumber;

  final double resistance;
  final double acceleration;

  final double height;
  final double borderWidth;
  final Color pickedBarColor;
  final Color barColor;

  final double longVerticalLineHeightRatio;
  final double shortVerticalLineHeightRatio;
  final double selectedVerticalLineHeightRatio;

  final TextStyle labelTextStyle;

  const RulerPicker({
    super.key,
    required this.initNumber,
    required this.height,
    required this.callbackDouble,
    this.callbackInt,
    this.linesType = MoonRulerLinesType.lineWithLabel,
    this.borderWidth = 1,
    this.pickedBarColor = Colors.blueAccent,
    this.barColor = Colors.blue,
    this.longVerticalLineHeightRatio = 0.8,
    this.shortVerticalLineHeightRatio = 0.72,
    this.selectedVerticalLineHeightRatio = 1,
    double resistance = 1,
    double acceleration = 1,
    this.maxNumber = 100,
    this.minNumber = 0,
    this.labelTextStyle = const TextStyle(
      fontSize: 10,
      color: Colors.blue
    )
  })
    : resistance = 1.02 * resistance,
      acceleration = 0.5 * acceleration ;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RulerPickerRenderBox(
      selectedNumber: initNumber,
      callbackDouble: callbackDouble,
      callbackInt: callbackInt,
      maxNumber: maxNumber,
      minNumber: minNumber,
      resistance: resistance,
      acceleration: acceleration,
      height: height,
      borderWidth: borderWidth,
      pickedBarColor: pickedBarColor,
      barColor: barColor,
      longVerticalLineHeightRatio: longVerticalLineHeightRatio,
      shortVerticalLineHeightRatio: shortVerticalLineHeightRatio,
      selectedVerticalLineHeightRatio: selectedVerticalLineHeightRatio,
      textStyle: labelTextStyle,
      linesType: linesType
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RulerPickerRenderBox renderObject) {

    if(initNumber != renderObject.selectedNumber ||
        callbackDouble != renderObject.callbackDouble ||
        callbackInt != renderObject.callbackInt ||
        maxNumber != renderObject.maxNumber ||
        minNumber != renderObject.minNumber ||
        resistance != renderObject.resistance ||
        acceleration != renderObject.acceleration ||
        height != renderObject.height ||
        borderWidth != renderObject.borderWidth ||
        pickedBarColor != renderObject.pickedBarColor ||
        barColor != renderObject.barColor ||
        longVerticalLineHeightRatio != renderObject.longVerticalLineHeightRatio ||
        shortVerticalLineHeightRatio != renderObject.shortVerticalLineHeightRatio ||
        selectedVerticalLineHeightRatio != renderObject.selectedVerticalLineHeightRatio ||
        labelTextStyle != renderObject.textStyle ||
        linesType != renderObject.linesType
    ) {
      renderObject.callbackDouble = callbackDouble;
      renderObject.callbackInt = callbackInt;
      renderObject.maxNumber = maxNumber;
      renderObject.minNumber = minNumber;
      renderObject.resistance = resistance;
      renderObject.acceleration = acceleration;
      renderObject.height = height;
      renderObject.borderWidth = borderWidth;
      renderObject.pickedBarColor = pickedBarColor;
      renderObject.barColor = barColor;
      renderObject.longVerticalLineHeightRatio = longVerticalLineHeightRatio;
      renderObject.shortVerticalLineHeightRatio = shortVerticalLineHeightRatio;
      renderObject.selectedVerticalLineHeightRatio = selectedVerticalLineHeightRatio;
      renderObject.textStyle = labelTextStyle;
      renderObject.linesType = linesType;

      renderObject.markNeedsLayout();
    }
  }
}


class _RulerPickerRenderBox extends RenderBox {

  Timer? _timer;
  late TextPainter _textPainter;

  MoonRulerLinesType linesType;
  double selectedNumber;
  Function(double) callbackDouble;
  Function(int)? callbackInt;
  int maxNumber;
  int minNumber;
  double resistance;
  double acceleration;

  double height;
  double borderWidth;
  Color pickedBarColor;
  Color barColor;

  double longVerticalLineHeightRatio;
  double shortVerticalLineHeightRatio;
  double selectedVerticalLineHeightRatio;

  TextStyle textStyle;

  double get rulerBetweenAlignWidth => 8;

  late int prev;
  bool _pointerDown = false;
  Offset? _startPosition;
  DateTime? _startTime;
  bool _isDragMinus = false;
  double _velocity = 0;

  _RulerPickerRenderBox({
    required this.callbackDouble,
    required this.callbackInt,
    required this.selectedNumber,
    required this.height,
    required this.borderWidth,
    required this.pickedBarColor,
    required this.barColor,
    required this.longVerticalLineHeightRatio,
    required this.shortVerticalLineHeightRatio,
    required this.selectedVerticalLineHeightRatio,
    required this.resistance,
    required this.acceleration,
    required this.maxNumber,
    required this.minNumber,
    required this.textStyle,
    required this.linesType
  }) {
    prev = selectedNumber.floor();
    _textPainter = TextPainter(textDirection: TextDirection.ltr,);
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    _textPainter.text = TextSpan(text: "5", style: textStyle);
    _textPainter.layout();
  }

  @override
  void detach() {
    _timer?.cancel();
    _timer = null;
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {

    _MoonRulerDrawer rulerDrawer = _MoonRulerDrawer(
        selectedNumber: selectedNumber,
        color: barColor,
        selectedColor: pickedBarColor,
        strokeWidth: borderWidth,
        rulerPickerHeight: height,
        size: size,
        lineBetweenAlignWidth: rulerBetweenAlignWidth,
        longVerticalLineHeightRatio: longVerticalLineHeightRatio,
        shortVerticalLineHeightRatio: shortVerticalLineHeightRatio,
        maxNumber: maxNumber,
        minNumber: minNumber,
        pickedVerticalLineHeightRatio: selectedVerticalLineHeightRatio,
        textStyle: textStyle,
        textPainter: _textPainter
    );

    rulerDrawer.getLines(linesType).draw(context, offset);
    rulerDrawer.getPickedLine(linesType).draw(context, offset);
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {

    if(selectedNumber.isNaN || selectedNumber.isInfinite) { return; }

    if (event is PointerDownEvent) {
      _timer?.cancel();
      _timer = null;
      _startPosition = event.position;
      _startTime = DateTime.now();
      _pointerDown = true;
    } else if(event is PointerMoveEvent && _pointerDown ) {

      if(_isDragMinus != event.delta.dx < 0) {
        _startPosition = event.position;
        _startTime = DateTime.now();
        _pointerDown = true;
        _isDragMinus = event.delta.dx < 0;
      }

      _updateDrag(event);
      markNeedsPaint();

    } else if(event is PointerUpEvent && _pointerDown) {
      _pointerDown = false;

      _shootDrag(event);
    }
  }

  void _updateDrag(details) {
    double delta = details.delta.dx;

    _moveRulerPicker(delta);
    _limitMaxNumber();
    _limitMinNumber();

    _vibratingOnIntegerValue();

    callbackDouble(selectedNumber);
    callbackInt == null ? null : callbackInt!(selectedNumber.floor());
  }

  void _shootDrag(details) {

    if(DateTime.now().difference(_startTime!).inMilliseconds < 0.01) {
      return;
    }

    if(_timer?.isActive ?? false) {
      _timer?.cancel();
      _timer = null;
    }

    final duration = DateTime.now().difference(_startTime!);
    final deltaX = details.position.dx - _startPosition!.dx;
    _velocity = ( deltaX / duration.inMilliseconds );
    _velocity *= acceleration;

    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {

      _velocity = _velocity / resistance;
      selectedNumber -= _velocity;
      _limitMaxNumber();
      _limitMinNumber();

      callbackDouble(selectedNumber);
      callbackInt == null ? null : callbackInt!(selectedNumber.floor());

      _vibratingOnIntegerValue();

      if (_velocity.abs() < 0.1) {
        _timer?.cancel();
        _timer = null;
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

    if( (selectedNumber) >= maxNumber ) {
      selectedNumber =  maxNumber.toDouble();
    }
  }

  void _limitMinNumber() {

    if( (selectedNumber) <= minNumber ) {
      selectedNumber =  minNumber.toDouble();
    }
  }

  void _vibratingOnIntegerValue() {
    if ((selectedNumber.floor() - prev).abs() >= 0.5) {
      HapticFeedback.selectionClick();
      prev = selectedNumber.floor();
    }
  }
}