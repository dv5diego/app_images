import 'package:flutter/material.dart';
// import 'dart:convert';

import 'package:app_images/pages/export_pages.dart';


class AppRoute{
  
  static const initialRoute='home-page';

  AppRoute();

  static Map<String,WidgetBuilder> getApplicationRoutes(){
    return <String, WidgetBuilder>{
      'splash-screen'  : (BuildContext context)=> SplashScreenPage(),
      'app-page'       : (BuildContext context)=> AppPage(),
      'home-page'      : (BuildContext context)=> HomePage()
    };
  }

}