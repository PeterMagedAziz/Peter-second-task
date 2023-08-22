import 'package:flutter/material.dart';
import 'package:peter_s_application2/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get fill => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
      );
  static BoxDecoration get fill1 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
  static BoxDecoration get gradientnamedeeppurpleA700nameprimary =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0.5,
            0,
          ),
          end: Alignment(
            0.5,
            1,
          ),
          colors: [
            appTheme.deepPurpleA700,
            theme.colorScheme.primary,
          ],
        ),
      );
  static BoxDecoration get outline => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: getHorizontalSize(
            2,
          ),
        ),
      );
  static BoxDecoration get fill2 => BoxDecoration(
        color: appTheme.whiteA700,
      );
  static BoxDecoration get txtFill => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
}

class BorderRadiusStyle {
  static BorderRadius customBorderBR6 = BorderRadius.only(
    bottomRight: Radius.circular(
      getHorizontalSize(
        6,
      ),
    ),
  );

  static BorderRadius txtCircleBorder16 = BorderRadius.circular(
    getHorizontalSize(
      16,
    ),
  );

  static BorderRadius roundedBorder6 = BorderRadius.circular(
    getHorizontalSize(
      6,
    ),
  );

  static BorderRadius customBorderBL6 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        6,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        6,
      ),
    ),
  );

  static BorderRadius customBorderTL6 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        6,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        6,
      ),
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
