import 'package:flutter/material.dart';
import 'package:PicToShare/misc/colors.dart';

class AppBackground extends StatelessWidget {
  final firstCircle, secondCircle, thirdCircle;
  AppBackground({this.firstCircle, this.secondCircle, this.thirdCircle});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final height = constraint.maxHeight;
        final width = constraint.maxWidth;

        print('height: $height width: $width');
        return Stack(
          children: <Widget>[
            Container(
              color: backgroundColor,
            ),
            Positioned(
              left: -(height / 2 - width / 2),
              bottom: height * 1 / 4,
              child: Container(
                height: height,
                width: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: firstCircle,
                ),
              ),
            ),
            Positioned(
              left: width * 0.15,
              top: -(width * 0.70),
              child: Container(
                height: width * 1.5,
                width: width * 1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondCircle,
                ),
              ),
            ),
            Positioned(
              right: -width * 0.15,
              top: -55,
              child: Container(
                height: width * 0.5,
                width: width * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: thirdCircle,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
