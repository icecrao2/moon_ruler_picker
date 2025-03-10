

part of ruler_picker_lib;



class _PickedVerticalRulerLine extends _MoonRulerDrawer {
  _PickedVerticalRulerLine({
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
    final selectedXPoint = offset.dy + (size.height / 2);


    if(selectedNumber.round() % 5 == 0) {
      var longVerticalDiff = (rulerPickerHeight * longVerticalLineHeightRatio * pickedVerticalLineHeightRatio - rulerPickerHeight * longVerticalLineHeightRatio) / 2;
      if(longYTopPoint - longVerticalDiff < offset.dy) { longVerticalDiff = 0; }
      path
        ..moveTo(offset.dx, selectedXPoint)
        ..lineTo(longYTopPoint + (rulerPickerHeight * longVerticalLineHeightRatio), selectedXPoint);

      path
        ..moveTo(longYTopPoint - longVerticalDiff, selectedXPoint)
        ..lineTo(longYTopPoint + (rulerPickerHeight * longVerticalLineHeightRatio), selectedXPoint);

    } else {
      var shortVerticalDiff = (rulerPickerHeight * shortVerticalLineHeightRatio * pickedVerticalLineHeightRatio - rulerPickerHeight * shortVerticalLineHeightRatio) / 2;
      if(shortYTopPoint - shortVerticalDiff < offset.dy) { shortVerticalDiff = 0; }
      path
        ..moveTo(offset.dx, selectedXPoint)
        ..lineTo(shortYTopPoint + (rulerPickerHeight * shortVerticalLineHeightRatio), selectedXPoint);
    }

    context.canvas.drawPath(path, paint);
  }
}