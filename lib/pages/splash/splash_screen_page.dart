import 'package:flutter/material.dart';

import 'package:app_images/utils/export_utils.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState(){ 
    super.initState();
    loadApp();
  }

  void loadApp() async{
    Future.delayed(
      const Duration(seconds: 3),(){
        Navigator.pushReplacementNamed(context,'home-page');
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/front-page.jpg'),
              fit: BoxFit.fill
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  height: responsive.dp(6.0),
                  width: responsive.dp(6.0),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green[700],
                    strokeWidth: 5.0,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
            ] 
          ),
        ),
      ),
    );
  }
}