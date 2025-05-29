import 'package:crypto_app/constants/theme.dart';
import 'package:crypto_app/models/local_storage.dart';
import 'package:crypto_app/providers/market_provider.dart';
import 'package:crypto_app/providers/theme_provider.dart';
import 'package:crypto_app/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? '';
  runApp(MyApp(theme: currentTheme));
}

class MyApp extends StatelessWidget {
  final String theme;

  const MyApp({super.key, required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
