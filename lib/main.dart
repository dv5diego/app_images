import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:app_images/providers/export_providers.dart';
import 'package:app_images/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CategoryProvider()),
        ChangeNotifierProvider(create: (_)=>ProductProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Images App',
        initialRoute: 'splash-screen',
        routes: AppRoute.getApplicationRoutes(),
      ),
    );
  }
}