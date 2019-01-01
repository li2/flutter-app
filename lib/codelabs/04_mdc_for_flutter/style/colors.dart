import 'package:flutter/material.dart';

const kShrinePink50 = const Color(0xFFFEEAE6);
const kShrinePink100 = const Color(0xFFFEDBD0);
const kShrinePink300 = const Color(0xFFFBB8AC);
const kShrinePink400 = const Color(0xFFEAA4A4);

const kShrineBrown900 = const Color(0xFF442B2D);

const kShrineErrorRed = const Color(0xFFC5032B);

const kShrineSurfaceWhite = const Color(0xFFFFFBFA);
const kShrineBackgroundWhite = Colors.white;

const kShrineAltDarkGrey = const Color(0xFF414149);
const kShrineAltYellow = const Color(0xFFFFCF44);

/*
 Add AccentColorOverride.
 Type into a text field—decorations and floating placeholder renders in the correct Accent color. But we can't see it very easily. It's not accessible to people who have trouble distinguishing pixels that don't have a high enough color contrast. (For more information, see "Accessible colors" in the Material Guidelines Color article.) Let's make a special class to override the Accent color for a widget to be the PrimaryVariant the designer gave us in the color theme above
 https://codelabs.developers.google.com/codelabs/mdc-103-flutter/#4
 note21：Accent color 是比较浅的粉红色，textFiled 边框被渲染成这个颜色，在 login 界面不容易区分。
 所以通过这个类改变默认的 accent color 属性。我们可以通过这种方式改变其它默认属性。
 Widget 果然是 Composition.
 Composition. In Flutter, everything is a widget, and you achieve any desired outcome by freely composing focused widgets, Lego brick style.
 */
class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
    : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark
      ),
    );
  }
}
