import 'package:material_ui/material_ui.dart';

/// A compact, theme-colored redraw inspired by AICU's avatar favicon. It is
/// not the site's artwork or an official logo/endorsement.
class AicuMark extends StatelessWidget {
  const AicuMark({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    return CustomPaint(
      size: Size.square(size),
      painter: _AicuMarkPainter(
        outline: colors.primary,
        accent: colors.tertiary,
        face: colors.primaryContainer,
        features: colors.onPrimaryContainer,
      ),
    );
  }
}

class _AicuMarkPainter extends CustomPainter {
  const _AicuMarkPainter({
    required this.outline,
    required this.accent,
    required this.face,
    required this.features,
  });

  final Color outline;
  final Color accent;
  final Color face;
  final Color features;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;
    canvas.save();
    canvas.scale(scale);
    final hairPaint = Paint()
      ..color = accent
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final facePaint = Paint()
      ..color = face
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final detailPaint = Paint()
      ..color = features
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final outlinePaint = Paint()
      ..color = outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final hair = Path()
      ..moveTo(4, 12)
      ..cubicTo(2.4, 5.2, 6.2, 2, 12, 2)
      ..cubicTo(18.2, 2, 21.2, 6.5, 19.7, 12)
      ..lineTo(20.3, 20)
      ..cubicTo(17.8, 19.6, 16.4, 16.8, 16, 13.5)
      ..lineTo(8, 13.5)
      ..cubicTo(7.6, 17.2, 6.1, 19.7, 3.7, 20)
      ..close();
    canvas.drawPath(hair, hairPaint);

    final head = RRect.fromRectAndRadius(
      const Rect.fromLTWH(7, 7, 10, 12),
      const Radius.circular(5),
    );
    canvas.drawRRect(head, facePaint);
    canvas.drawRRect(head, outlinePaint);

    final fringe = Path()
      ..moveTo(5.3, 9)
      ..cubicTo(6.4, 5.5, 9, 4, 12, 4)
      ..cubicTo(15.5, 4, 17.8, 6, 19, 9)
      ..lineTo(15.6, 10)
      ..lineTo(13.2, 7.8)
      ..lineTo(11.1, 10.2)
      ..lineTo(8.8, 8.7)
      ..close();
    canvas.drawPath(fringe, hairPaint);
    canvas.drawCircle(const Offset(10, 13), 0.65, detailPaint);
    canvas.drawCircle(const Offset(14, 13), 0.65, detailPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_AicuMarkPainter oldDelegate) =>
      outline != oldDelegate.outline ||
      accent != oldDelegate.accent ||
      face != oldDelegate.face ||
      features != oldDelegate.features;
}
