

part of ruler_picker_lib;



class _VerticalLine extends StatelessWidget {

  final double height;
  final double width;
  final Color color;

  const _VerticalLine({required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: VerticalDivider(
        width: width,
        thickness: width,
        color: color,
      ),
    );
  }
}