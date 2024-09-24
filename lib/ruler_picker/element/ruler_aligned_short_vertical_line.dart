

part of ruler_picker_lib;



class _RulerAlignedShortVerticalLine extends StatelessWidget {

  final double standardNumber;
  final int myNumber;
  final double alignX;

  final double height;
  final double width;
  final Color pickedColor;
  final Color color;

  double get _diff => (standardNumber - myNumber);
  bool get _widgetStandard => (myNumber % 5 == 1 && standardNumber - myNumber < 0) ? (_diff < 0.5 && _diff >= -0.5 ) : (_diff <= 0.5 && _diff > -0.5 );

  const _RulerAlignedShortVerticalLine({required this.standardNumber, required this.myNumber, required this.width, required this.height, required this.color, required this.pickedColor, required this.alignX});

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment(alignX, 0.0),
      child: _widgetStandard ? _VerticalLine(width: width * 1.2, height: height * 1.46, color: pickedColor,) : _VerticalLine(width: width, height: height, color: color,)
    );
  }
}
