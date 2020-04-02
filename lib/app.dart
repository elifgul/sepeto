import 'package:flutter/material.dart';

import 'backdrop.dart';
import 'category_menu_page.dart';
import 'colors.dart';
import 'home.dart';
import 'login.dart';
import 'model/product.dart';
import 'supplemental/cut_corners_border.dart';

class Sepeto extends StatefulWidget {
  @override
  _SepetoState createState() => _SepetoState();
}

class _SepetoState extends State<Sepeto> {
  Category _currentCategory = Category.ALL;

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEPETO',
      home: Backdrop(
        currentCategory: _currentCategory,
        frontLayer: HomePage(category: _currentCategory),
        backLayer: CategoryMenuPage(
          currentCategory: _currentCategory,
          onCategoryTap: _onCategoryTap,
        ),
        frontTitle: Text('SEPETO'),
        backTitle: Text('MENÜ'),
      ),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _kTheme,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}

final ThemeData _kTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: orange900,
    primaryColor: orange100,
    buttonColor: orange100,
    scaffoldBackgroundColor: backgroundWhite,
    cardColor: backgroundWhite,
    textSelectionColor: orange100,
    errorColor: errorRed,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: orange100,
      colorScheme: base.colorScheme.copyWith(
        secondary: orange900,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: orange900),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: orange900,
        bodyColor: orange900,
      );
}
