import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ignition_hacks/finance_data.dart';
import 'package:ignition_hacks/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

final ThemeData themeData = ThemeData(
  primaryColor: Color.fromRGBO(0, 108, 209, 1),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color.fromRGBO(0, 108, 209, 1)),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => FinancialData(),
      child: MaterialApp(theme: themeData, home: WelcomeScreen()),
    ),
  );
}
