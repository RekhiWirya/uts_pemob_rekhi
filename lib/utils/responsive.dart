import 'package:flutter/widgets.dart';


enum DeviceType { mobile, tablet, desktop }


class Responsive {
  Responsive._();


  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;


  static const double maxContentWidth = 640;


  static const double _designWidth = 390;

  static DeviceType deviceTypeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobileBreakpoint) return DeviceType.mobile;
    if (width < tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.desktop;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;


  static T value<T>(
      BuildContext context, {
        required T mobile,
        T? tablet,
        T? desktop,
      }) {
    return switch (deviceTypeOf(context)) {
      DeviceType.desktop => desktop ?? tablet ?? mobile,
      DeviceType.tablet => tablet ?? mobile,
      DeviceType.mobile => mobile,
    };
  }


  static double widthPercent(BuildContext context, double percent) =>
      MediaQuery.sizeOf(context).width * percent / 100;


  static double heightPercent(BuildContext context, double percent) =>
      MediaQuery.sizeOf(context).height * percent / 100;


  static double scaleOf(BuildContext context) {
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    return (shortest / _designWidth).clamp(0.85, 1.3).toDouble();
  }


  static double scale(BuildContext context, double size) =>
      size * scaleOf(context);
}


extension ResponsiveContext on BuildContext {
  DeviceType get deviceType => Responsive.deviceTypeOf(this);
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  bool get isLandscape => Responsive.isLandscape(this);
  double scale(double size) => Responsive.scale(this, size);
}