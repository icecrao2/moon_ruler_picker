

part of ruler_picker_lib;



class _RulerPickedShortVerticalLine extends StatelessWidget {

  final double height;
  final double width;
  final Color color;

  const _RulerPickedShortVerticalLine({required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      color: color
    );
  }
}