import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_app/thumb.dart';

class CircleDegreePickerController extends ChangeNotifier {
  CircleDegreePickerController({
    required double degree,
  }) : _degree = degree;

  double _degree;
  double get degree => _degree;
  set degree(double degree) {
    _degree = degree;
    notifyListeners();
  }
}

class CircleDegreePicker extends StatefulWidget {
  const CircleDegreePicker({
    Key? key,
    this.onDegreeChange,
    this.controller,
    this.child,
  }) : super (key: key);

    final ValueChanged<double>? onDegreeChange;
    final CircleDegreePickerController? controller;
    final Widget? child;

    @override
  _CirclePicker createState() {
    return _CirclePicker();
  }
}

class _CirclePicker extends State<CircleDegreePicker> with TickerProviderStateMixin {

  double degree = 0.0;
  double size = 280;
  double thumbSize = 30;

  @override
  Widget build(BuildContext context) {
    final offset = _CircleTween(
      size / 2 - 30 / 2,
    ).lerp(degree * pi / 180);
    return GestureDetector(
      onHorizontalDragUpdate: _updatePosition,
      onVerticalDragUpdate: _updatePosition,
      onHorizontalDragStart: _updatePositionStart,
      onVerticalDragStart: _updatePositionStart,
      onPanDown: _onDown,
      child: Center(child: Stack(
          children: <Widget>[
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                  foregroundPainter: CirclePicker(
                    lineWidth: 4,
                    radius: size / 2 - thumbSize / 2,
                  ),
                  child: widget.child!,
                ),
              ),
            Positioned(
              left: offset.dx,
              top: offset.dy,
              child: ThumbIndicator(
                size: thumbSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    widget.controller?.addListener(setDegree);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(setDegree);
    super.dispose();
  }

  void setDegree() {
    if (widget.controller != null && widget.controller!.degree != degree) {
      degree = widget.controller!.degree;
    }
  }

  void _onDown(DragDownDetails details) {
    _updatePositionOffset(details.localPosition);  
  }

  void _updatePositionStart(DragStartDetails details) {
    _updatePositionOffset(details.localPosition);
  }

  void _updatePosition(DragUpdateDetails details) {
    _updatePositionOffset(details.localPosition);
  }

  void _updatePositionOffset(Offset offset) {
    final radians = atan2(
      offset.dy - size / 2 - thumbSize,
      offset.dx - size / 2 - thumbSize,
    );
    double degree = radians % (2 * pi) * 180 / pi;
    widget.onDegreeChange?.call(degree);
    widget.controller?.degree = degree;
  }
}

class CirclePicker extends CustomPainter {
  const CirclePicker ({
    required this.lineWidth,
    required this.radius,
  });

  final double radius;
  final double lineWidth;

@override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.strokeWidth = lineWidth;
    paint.style = PaintingStyle.stroke;
    paint.color = Color.fromARGB(255, 0, 95, 129);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

 @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _CircleTween extends Tween<Offset> {
  _CircleTween(this.radius)
      : super(
          begin: _radiansToOffset(0, radius),
          end: _radiansToOffset(2 * pi, radius),
        );

  final double radius;

  @override
  Offset lerp(double t) => _radiansToOffset(t, radius);

  static Offset _radiansToOffset(double radians, double radius) {
    return Offset(
      radius + radius * cos(radians),
      radius + radius * sin(radians),
    );
  }
}