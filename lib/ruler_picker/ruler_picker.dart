

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

  final double rulerBetweenAlignWidth;


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
      linesType: linesType,
      rulerBetweenAlignWidth: rulerBetweenAlignWidth,
      dragType: linesType == MoonRulerLinesType.verticalLine ? DragType.vertical : DragType.horizontal
    );
  }

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
    ),
    this.rulerBetweenAlignWidth = 8,
  })
    : resistance = 1.02 * resistance,
      acceleration = 0.5 * acceleration ;

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
      renderObject.selectedNumber = initNumber;
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

  double rulerBetweenAlignWidth;

  late int prev;
  bool _pointerDown = false;
  Offset? _startPosition;
  DateTime? _startTime;
  bool _isDragMinus = false;
  double _velocity = 0;

  DragType dragType;

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
    required this.linesType,
    required this.rulerBetweenAlignWidth,
    required this.dragType
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
    if (selectedNumber.isNaN || selectedNumber.isInfinite) {
      return;
    }

    if (event is PointerDownEvent) {
      _timer?.cancel();
      _timer = null;
      _startPosition = event.position;
      _startTime = DateTime.now();
      _pointerDown = true;
    }
    else if (event is PointerMoveEvent && _pointerDown) {
      // 드래그 방향에 따라 사용할 delta 결정
      double primaryDelta = (dragType == DragType.horizontal)
          ? event.delta.dx
          : event.delta.dy;

      // 드래그 방향(양수/음수) 변경 체크
      if (_isDragMinus != (primaryDelta < 0)) {
        _startPosition = event.position;
        _startTime = DateTime.now();
        _pointerDown = true;
        _isDragMinus = (primaryDelta < 0);
      }

      _updateDrag(primaryDelta);
      markNeedsPaint();
    }
    else if (event is PointerUpEvent && _pointerDown) {
      _pointerDown = false;
      _shootDrag(event);
    }
  }

  void _updateDrag(double delta) {
    _moveRulerPicker(delta);
    _limitMaxNumber();
    _limitMinNumber();

    _vibratingOnIntegerValue();

    // 콜백 호출
    callbackDouble?.call(selectedNumber);
    if (callbackInt != null) {
      callbackInt!(selectedNumber.floor());
    }
  }

  void _shootDrag(PointerUpEvent details) {
    if (DateTime.now().difference(_startTime!).inMilliseconds < 10) {
      return;
    }

    // 타이머 정리
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
      _timer = null;
    }

    // (x 혹은 y) 위치 차이를 통해 속도 계산
    final duration = DateTime.now().difference(_startTime!);
    final deltaMain = (dragType == DragType.horizontal)
        ? (details.position.dx - _startPosition!.dx)
        : (details.position.dy - _startPosition!.dy);

    _velocity = (deltaMain / duration.inMilliseconds) * acceleration;

    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      _velocity = _velocity / resistance;
      selectedNumber -= _velocity; // 위아래 / 좌우 동일하게 값 이동

      _limitMaxNumber();
      _limitMinNumber();

      callbackDouble?.call(selectedNumber);
      if (callbackInt != null) {
        callbackInt!(selectedNumber.floor());
      }

      _vibratingOnIntegerValue();
      markNeedsPaint();

      // 속도가 충분히 작으면 모멘텀 중지
      if (_velocity.abs() < 0.1) {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  // delta에 따라 selectedNumber 변화
  void _moveRulerPicker(double delta) {
    // delta 크기가 너무 큰 경우(> 5) 5로 제한
    if (delta > 5) {
      selectedNumber -= 5 * 0.2;
    } else if (delta < -5) {
      selectedNumber -= -5 * 0.2;
    } else {
      selectedNumber -= delta * 0.2;
    }
  }

  void _limitMaxNumber() {
    if (selectedNumber >= maxNumber) {
      selectedNumber = maxNumber.toDouble();
    }
  }

  void _limitMinNumber() {
    if (selectedNumber <= minNumber) {
      selectedNumber = minNumber.toDouble();
    }
  }

  // 정수값 변경 시 진동
  void _vibratingOnIntegerValue() {
    if ((selectedNumber.floor() - prev).abs() >= 0.5) {
      HapticFeedback.selectionClick();
      prev = selectedNumber.floor();
    }
  }

}