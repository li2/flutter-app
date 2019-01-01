import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/backdrop.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/category_menu_page.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/model/product.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/style/colors.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/home_page.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/login_page.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/supplemental/cut_corners_border.dart';

class ShrineApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      // Change home: to a Backdrop with a HomePage frontLayer
      home: Backdrop(
        currentCategory: _currentCategory,
        // Pass _currentCategory for frontLayer
        frontLayer: HomePage(category: _currentCategory,),
        // Change backLayer field value to CategoryMenuPage
        backLayer: CategoryMenuPage(
          currentCategory: _currentCategory,
          onCategoryTap: _onCategoryTap,
        ),
        frontTitle: Text('SHRINE'),
        backTitle: Text('MENU'),
      ),
      // todo weiyi: initialRoute? How to handle if we have a splash screen?
      // todo weiyi: can we move these const string to a file?
      initialRoute: '/login_page',
      // todo weiyi: how to mange onGenerateRoute?
      onGenerateRoute: _getRoute,
      // Add a theme (103)
      theme: _kShrineTheme,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login_page') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}

// Build a Shrine Theme
final ThemeData _kShrineTheme = _buildShrineTheme(); // todo weiyi global approach to manage App theme?

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900, // todo weiyi: Which widgets will be affected by accent, primary?
    primaryColor: kShrinePink100,
    brightness: Brightness.light,
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    // Add the text themes
    textTheme: _buildShrineTextTheme(base.textTheme), // todo weiyi: Which widgets will be affected by text, primary, accent?
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    // Add the button theme
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kShrinePink100,
      textTheme: ButtonTextTheme.normal,
    ),
    // Add the icon themes
    primaryIconTheme: base.iconTheme.copyWith(
      color: kShrineBrown900
    ),
    // Decorate the inputs
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
  );
}

// Build a Shrine Text Theme (103)
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
      fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    body2: base.body2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900,
  );
}

ThemeData _buildShrineDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    accentColor: kShrineAltDarkGrey,
    primaryColor: kShrineAltDarkGrey,
    buttonColor: kShrineAltYellow,
    scaffoldBackgroundColor: kShrineAltDarkGrey,
    cardColor: kShrineAltDarkGrey,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextDarkTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextDarkTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextDarkTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(
        color: kShrineAltYellow
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
  );
}

TextTheme _buildShrineTextDarkTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
        fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: kShrineSurfaceWhite,
    bodyColor: kShrineSurfaceWhite,
  );
}
