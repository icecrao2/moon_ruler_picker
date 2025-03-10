

part of ruler_picker_lib;



class _PickedBottomRulerLine extends _MoonRulerDrawer {

  _PickedBottomRulerLine({
    required super.selectedNumber,
    required super.color,
    required super.selectedColor,
    required super.strokeWidth,
    required super.rulerPickerHeight,
    required super.size,
    required super.lineBetweenAlignWidth,
    required super.longVerticalLineHeightRatio,
    required super.shortVerticalLineHeightRatio,
    required super.maxNumber,
    required super.minNumber,
    required super.pickedVerticalLineHeightRatio,
    required super.textStyle,
    required super.textPainter
  });

  @override
  void draw(PaintingContext context, Offset offset) {

    final paint = Paint()
      ..color = selectedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();

    final lineTopPoint = offset.dy;
    final longYTopPoint = lineTopPoint + (rulerPickerHeight * (1 - longVerticalLineHeightRatio));
    final shortYTopPoint = lineTopPoint + (rulerPickerHeight * (1 - shortVerticalLineHeightRatio));
    final selectedXPoint = offset.dx + (size.width / 2);


    if(selectedNumber.round() % 5 == 0) {
      var longVerticalDiff = (rulerPickerHeight * longVerticalLineHeightRatio * pickedVerticalLineHeightRatio - rulerPickerHeight * longVerticalLineHeightRatio) / 2;
      if(longYTopPoint - longVerticalDiff < offset.dy) { longVerticalDiff = 0; }
      path
        ..moveTo(selectedXPoint, longYTopPoint - longVerticalDiff)
        ..lineTo(selectedXPoint, longYTopPoint + (rulerPickerHeight * longVerticalLineHeightRatio));

    } else {
      var shortVerticalDiff = (rulerPickerHeight * shortVerticalLineHeightRatio * pickedVerticalLineHeightRatio - rulerPickerHeight * shortVerticalLineHeightRatio) / 2;
      if(shortYTopPoint - shortVerticalDiff < offset.dy) { shortVerticalDiff = 0; }
      path
        ..moveTo(selectedXPoint, shortYTopPoint - shortVerticalDiff)
        ..lineTo(selectedXPoint, shortYTopPoint + (rulerPickerHeight * shortVerticalLineHeightRatio));
    }

    context.canvas.drawPath(path, paint);
  }
}