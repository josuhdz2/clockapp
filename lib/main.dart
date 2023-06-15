import 'package:flutter/material.dart';
import 'package:reloj_aplicacion/counter/counterPage.dart';
import 'package:wear/wear.dart';
void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return AmbientMode
    (
      child: const CounterPage(),
      builder: (context, mode, child)
      {
        return MaterialApp
        (
          theme: ThemeData
          (
            visualDensity: VisualDensity.compact,
            useMaterial3: true,
            colorScheme: mode==WearMode.active?const ColorScheme.dark(primary: Color(0xff00b5ff)):const ColorScheme.dark(primary: Colors.white24, onBackground: Colors.white10, onSurface: Colors.white10),
          ),
          home:child,
        );
      }
    );
  }
}