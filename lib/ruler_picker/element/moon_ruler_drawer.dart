

part of ruler_picker_lib;



class _MoonRulerDrawer {

  final double selectedNumber;
  final Color color;
  final Color selectedColor;
  final double strokeWidth;
  final double rulerPickerHeight;
  final Size size;
  final double lineBetweenAlignWidth;
  final double longVerticalLineHeightRatio;
  final double shortVerticalLineHeightRatio;
  final int maxNumber;
  final int minNumber;
  final double pickedVerticalLineHeightRatio;
  final TextStyle textStyle;
  final TextPainter textPainter;

  _MoonRulerDrawer({
    required this.selectedNumber,
    required this.color,
    required this.selectedColor,
    required this.strokeWidth,
    required this.rulerPickerHeight,
    required this.size,
    required this.lineBetweenAlignWidth,
    required this.longVerticalLineHeightRatio,
    required this.shortVerticalLineHeightRatio,
    required this.maxNumber,
    required this.minNumber,
    required this.pickedVerticalLineHeightRatio,
    required this.textStyle,
    required this.textPainter
  });

  void draw(PaintingContext context, Offset offset) { }

  _MoonRulerDrawer getPickedLine(MoonRulerLinesType type) {

    switch(type) {
      case MoonRulerLinesType.line:
        return _PickedRulerLine(selectedNumber: selectedNumber, color: color, selectedColor: selectedColor, strokeWidth: strokeWidth, rulerPickerHeight: rulerPickerHeight, size: size, lineBetweenAlignWidth: lineBetweenAlignWidth, longVerticalLineHeightRatio: longVerticalLineHeightRatio, shortVerticalLineHeightRatio: shortVerticalLineHeightRatio, maxNumber: maxNumber, minNumber: minNumber, pickedVerticalLineHeightRatio: pickedVerticalLineHeightRatio, textStyle: textStyle, textPainter: textPainter);
      case MoonRulerLinesType.lineWithLabel:
        return _PickedRulerLine(selectedNumber: selectedNumber, color: color, selectedColor: selectedColor, strokeWidth: strokeWidth, rulerPickerHeight: rulerPickerHeight, size: size, lineBetweenAlignWidth: lineBetweenAlignWidth, longVerticalLineHeightRatio: longVerticalLineHeightRatio, shortVerticalLineHeightRatio: shortVerticalLineHeightRatio, maxNumber: maxNumber, minNumber: minNumber, pickedVerticalLineHeightRatio: pickedVerticalLineHeightRatio, textStyle: textStyle, textPainter: textPainter);
      case MoonRulerLinesType.circularLine:
        return _PickedCircularRulerLine(selectedNumber: selectedNumber, color: color, selectedColor: selectedColor, strokeWidth: strokeWidth, rulerPickerHeight: rulerPickerHeight, size: size, lineBetweenAlignWidth: lineBetweenAlignWidth, longVerticalLineHeightRatio: longVerticalLineHeightRatio, shortVerticalLineHeightRatio: shortVerticalLineHeightRatio, maxNumber: maxNumber, minNumber: minNumber, pickedVerticalLineHeightRatio: pickedVerticalLineHeightRatio, textStyle: textStyle, textPainter: textPainter);
    }
  }

  _MoonRulerDrawer getLines(MoonRulerLinesType type) {

    switch(type) {
      case MoonRulerLinesType.line:
        return _RulerLines(selectedNumber: selectedNumber, color: color, selectedColor: selectedColor, strokeWidth: strokeWidth, rulerPickerHeight: rulerPickerHeight, size: size, lineBetweenAlignWidth: lineBetweenAlignWidth, longVerticalLineHeightRatio: longVerticalLineHeightRatio, shortVerticalLineHeightRatio: shortVerticalLineHeightRatio, maxNumber: maxNumber, minNumber: minNumber, pickedVerticalLineHeightRatio: pickedVerticalLineHeightRatio, textStyle: textStyle, textPainter: textPainter);
      case MoonRulerLinesType.lineWithLabel:
        return _RulerLinesWithLabel(selectedNumber: selectedNumber, color: color, selectedColor: selectedColor, strokeWidth: strokeWidth, rulerPickerHeight: rulerPickerHeight, size: size, lineBetweenAlignWidth: lineBetweenAlignWidth, longVerticalLineHeightRatio: longVerticalLineHeightRatio, shortVerticalLineHeightRatio: shortVerticalLineHeightRatio, maxNumber: maxNumber, minNumber: minNumber, pickedVerticalLineHeightRatio: pickedVerticalLineHeightRatio, textStyle: textStyle, textPainter: textPainter);
      case MoonRulerLinesType.circularLine:
        return _RulerCircularLines(selectedNumber: selectedNumber, color: color, selectedColor: selectedColor, strokeWidth: strokeWidth, rulerPickerHeight: rulerPickerHeight, size: size, lineBetweenAlignWidth: lineBetweenAlignWidth, longVerticalLineHeightRatio: longVerticalLineHeightRatio, shortVerticalLineHeightRatio: shortVerticalLineHeightRatio, maxNumber: maxNumber, minNumber: minNumber, pickedVerticalLineHeightRatio: pickedVerticalLineHeightRatio, textStyle: textStyle, textPainter: textPainter);
    }
  }
}
