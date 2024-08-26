

part of ruler_picker_lib;



class _RulerLongVerticalLine extends StatelessWidget {

  final double height;
  final double width;
  final Color color;

  const _RulerLongVerticalLine({required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      color: color
    );
  }
}