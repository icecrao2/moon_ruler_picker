

part of ruler_picker_lib;



class _RulerCircularLines extends _MoonRulerDrawer{

  _RulerCircularLines({
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

  final double _rulerBetweenAngle = 6 * math.pi / 180;

  @override
  void draw(PaintingContext context, Offset offset) {

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();

    final rulerPickerHeight = this.rulerPickerHeight * 0.5 - textPainter.height * 2;
    final lineCount = ((360 * math.pi / 180) / _rulerBetweenAngle).toInt();
    final selectedNumber = double.tryParse(this.selectedNumber.toStringAsFixed(2)) ?? 0;

    for(int index = -(lineCount ~/ 2) ; index < lineCount ~/ 2; index++) {

      final myNumber = (selectedNumber + index).ceil();
      final myAngle = (index - selectedNumber + selectedNumber.ceil()) * _rulerBetweenAngle - (math.pi / 2);

      double longEndX = offset.dx + size.width / 2 + (rulerPickerHeight * longVerticalLineHeightRatio) * math.cos(myAngle); // x좌표
      double longEndY = offset.dy + size.height / 2 + (rulerPickerHeight * longVerticalLineHeightRatio) * math.sin(myAngle); // y좌표

      double shortEndX = offset.dx + size.width / 2 + (rulerPickerHeight * shortVerticalLineHeightRatio) * math.cos(myAngle); // x좌표
      double shortEndY = offset.dy + size.height / 2 + (rulerPickerHeight * shortVerticalLineHeightRatio) * math.sin(myAngle); // y좌표

      double labelEndX = offset.dx + size.width / 2 + (this.rulerPickerHeight * 0.5 - textPainter.height) * math.cos(myAngle); // x좌표
      double labelEndY = offset.dy + size.height / 2 + (this.rulerPickerHeight * 0.5 - textPainter.height) * math.sin(myAngle); // y좌표

      if(myNumber > maxNumber || myNumber < minNumber) { continue; }
      if(myNumber.round() == selectedNumber.round()) {
        if(myNumber % 5 == 0) {
          textPainter.text = TextSpan(text: "$myNumber", style: textStyle);
          textPainter.layout();
          textPainter.paint(context.canvas, Offset(labelEndX - textPainter.width / 2, labelEndY - textPainter.height / 2));
        }
        continue;
      }


      if(myNumber % 5 == 0) {
        path
          ..moveTo(offset.dx + size.width / 2, offset.dy + size.height / 2)
          ..lineTo(longEndX, longEndY);

        textPainter.text = TextSpan(text: "$myNumber", style: textStyle);
        textPainter.layout();
        textPainter.paint(context.canvas, Offset(labelEndX - textPainter.width / 2, labelEndY - textPainter.height / 2));
      } else{
        path
          ..moveTo(offset.dx + size.width / 2, offset.dy + size.height / 2)
          ..lineTo(shortEndX, shortEndY);
      }
    }

    context.canvas.drawPath(path, paint);
  }
}