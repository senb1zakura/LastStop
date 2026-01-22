import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool primary;
  final EdgeInsetsGeometry padding;
  final double elevation;

  const AppButton._({
    required this.onPressed,
    required this.child,
    required this.primary,
    required this.padding,
    required this.elevation,
    super.key,
  });

  factory AppButton.primary({Key? key, required VoidCallback? onPressed, required Widget child}) {
    return AppButton._(
      onPressed: onPressed,
      primary: true,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      elevation: 4,
      key: key,
      child: child,
    );
  }

  factory AppButton.secondary({Key? key, required VoidCallback? onPressed, required Widget child}) {
    return AppButton._(
      onPressed: onPressed,
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      elevation: 2,
      key: key,
      child: child,
    );
  }

  factory AppButton.ghost({Key? key, required VoidCallback? onPressed, required Widget child}) {
    return AppButton._(
      onPressed: onPressed,
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      elevation: 0,
      key: key,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = primary ? kPrimaryColor : kCardColor;
    final fg = primary ? Colors.white : kPrimaryColor;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: elevation,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: kRadius),
        shadowColor: kPrimaryColor.withAlpha(30),
      ),
      child: child,
    );
  }
}

class AppIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;
  final Color background;
  final double size;

  const AppIconButton({required this.onPressed, required this.icon, this.background = kCardColor, this.size = 44, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
