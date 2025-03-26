import 'package:contact_list/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:universal_html/html.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  final googleAPIElement =
      ScriptElement()
        ..src =
            'https://maps.googleapis.com/maps/api/js?key=${dotenv.get('GOOGLE_API_KEY')}&libraries=drawing';
  document.head?.append(googleAPIElement);
  usePathUrlStrategy();
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/login');

    return MaterialApp.router(
      title: 'Contact List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(8, 50, 93, 1),
        useMaterial3: false,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
