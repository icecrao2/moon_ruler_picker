

part of ruler_picker_lib;



class _PickedCircularRulerLine extends _MoonRulerDrawer {

  _PickedCircularRulerLine({
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

    final rulerPickerHeight = this.rulerPickerHeight * 0.5 - textPainter.height * 2;
    var length = (rulerPickerHeight * longVerticalLineHeightRatio * pickedVerticalLineHeightRatio);

    if(length > rulerPickerHeight) {
      length = rulerPickerHeight * longVerticalLineHeightRatio;
    }


    path
      ..moveTo(offset.dx + size.width / 2, offset.dy + size.height / 2)
      ..lineTo(offset.dx + size.width / 2, offset.dy + size.height / 2 - length);

    context.canvas.drawPath(path, paint);
  }

}
