

part of ruler_picker_lib;



class _RulerAlignedShortVerticalLine extends StatelessWidget {

  late double standardNumber;
  late int myNumber;
  late double alignX;

  late double height;
  late double width;
  late Color pickedColor;
  late Color color;


  double get _diff => (standardNumber - myNumber);
  bool get _widgetStandard => (
      (myNumber % 5 == 1 && standardNumber - myNumber < 0) ? (_diff < 0.5 && _diff >= -0.5 ) : (_diff <= 0.5 && _diff > -0.5 )
  );

  _RulerAlignedShortVerticalLine({required this.standardNumber, required double myNumber, required this.width, required this.height, required this.color, required this.pickedColor, required double rulerBetweenWidth}){
    this.myNumber = myNumber.floor();
    alignX = (this.myNumber - standardNumber) * rulerBetweenWidth;
  }

  @override
  Widget build(BuildContext context) {

    return Align(
        alignment: Alignment(alignX, 0.0),
        child: _widgetStandard ? _RulerPickedShortVerticalLine(width: width * 1.2, height: height * 1.46, color: pickedColor,) : _RulerShortVerticalLine(width: width, height: height, color: color,)
    );
  }
}
