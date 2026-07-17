import 'package:flutter/material.dart';
import 'package:rev_expense_app/widget/expenses_list/expenses.dart';
//import 'package:flutter/services.dart';// lock Orientations

var kColorScheme=ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));
var kDarkColorScheme=ColorScheme.fromSeed(
  brightness: Brightness.dark,
    seedColor: Color.fromARGB(255,5,99,125) );

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn){
    runApp(MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: CardThemeData(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme:const  AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,

        ),
        cardTheme: CardThemeData(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme:ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(fontWeight: FontWeight.bold,color: kColorScheme.onSecondaryContainer,fontSize: 16)
        ),
      ),
      ///themeMode: ThemeMode.system,//default
      home:Expenses() ,
    ));
}
