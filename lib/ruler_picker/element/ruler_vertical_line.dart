

part of ruler_picker_lib;



class _RulerVerticalLine extends StatelessWidget {

  final double standardNumber;
  final double myNumber;

  final double height;
  final double width;
  final Color pickedColor;
  final Color color;
  final double rulerBetweenAlignWidth;

  int get verticalLineNumber => myNumber.floor();
  double get alignX => (verticalLineNumber - standardNumber) * rulerBetweenAlignWidth;


  const _RulerVerticalLine({required this.standardNumber, required this.myNumber, required this.width, required this.height, required this.color, required this.pickedColor, required this.rulerBetweenAlignWidth});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        if (myNumber.floor() % 5 == 0) {
          return _RulerAlignedLongVerticalLine(standardNumber: standardNumber, myNumber: verticalLineNumber, width: width, height: constraints.maxHeight * 0.6, color: color, pickedColor: pickedColor, alignX: alignX,);
        } else {
          return _RulerAlignedShortVerticalLine(standardNumber: standardNumber, myNumber: verticalLineNumber, width: width, height: constraints.maxHeight * 0.34, color: color, pickedColor: pickedColor, alignX: alignX,);
        }

      }
    );
  }
}
