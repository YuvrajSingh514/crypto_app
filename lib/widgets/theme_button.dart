import 'package:crypto_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    return IconButton(
      onPressed: () {
        themeProvider.toggleTheme();
      },
      padding: EdgeInsets.all(0),
      icon:
          (themeProvider.themeMode == ThemeMode.light)
              ? Icon(Icons.dark_mode)
              : Icon(Icons.light_mode),
    );
  }
}
