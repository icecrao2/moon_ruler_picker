

part of ruler_picker_lib;



class _RulerBottomLines extends _MoonRulerDrawer{

  _RulerBottomLines({
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
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();

    final lineTopPoint = offset.dy;
    final lineCount = (size.width / (lineBetweenAlignWidth)).toInt();
    final longYTopPoint = lineTopPoint + (rulerPickerHeight * (1 - longVerticalLineHeightRatio));
    final shortYTopPoint = lineTopPoint + (rulerPickerHeight * (1 - shortVerticalLineHeightRatio));


    for(int index = -(lineCount ~/ 2) ; index < lineCount ~/ 2; index++) {

      final selectedNumber = double.tryParse(this.selectedNumber.toStringAsFixed(2)) ?? 0;
      final myNumber = (selectedNumber + index).ceil();
      final xPoint = offset.dx + (size.width / 2) + ((index - selectedNumber + selectedNumber.ceil()) * lineBetweenAlignWidth);

      if(myNumber > maxNumber || myNumber < minNumber) { continue; }
      if((index - selectedNumber + selectedNumber.ceil()).round() == (selectedNumber - selectedNumber).round()) { continue; }


      if(myNumber % 5 == 0) {
        path
          ..moveTo(xPoint, longYTopPoint)
          ..lineTo(xPoint, longYTopPoint + (rulerPickerHeight * longVerticalLineHeightRatio));

      } else {
        path
          ..moveTo(xPoint, shortYTopPoint)
          ..lineTo(xPoint, shortYTopPoint + (rulerPickerHeight * shortVerticalLineHeightRatio));
      }
    }

    context.canvas.drawPath(path, paint);
  }
}