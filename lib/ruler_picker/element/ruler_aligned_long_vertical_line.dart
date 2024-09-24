

part of ruler_picker_lib;



class _RulerAlignedLongVerticalLine extends StatelessWidget {

  final double standardNumber;
  final int myNumber;
  final double alignX;

  final double height;
  final double width;
  final Color pickedColor;
  final Color color;

  double get _diff => (standardNumber - myNumber).abs();
  bool get _widgetStandard => ( _diff < 0.5 );

  const _RulerAlignedLongVerticalLine({required this.standardNumber, required this.myNumber, required this.height, required this.width, required this.color, required this.pickedColor, required this.alignX});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        Align(
          alignment: Alignment(alignX, 0.0),
          child: _widgetStandard ? _VerticalLine(height: height, width: width * 1.2, color: pickedColor) : _VerticalLine(height: height, width: width, color: color)
        ),

        Align(
          alignment: Alignment(alignX * 1.05, 1.0),
          child: Text(
            myNumber.toStringAsFixed(0),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF0180BE),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 0.17,
            ),
          ),
        ),

      ]
    );
  }
}