import 'package:flutter/material.dart';

import 'package:app_images/utils/export_utils.dart';

class AppPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/front-page.jpg'),
            fit: BoxFit.fill,
          )
        ),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: responsive.dp(8.0)),
              width: responsive.isTablet? responsive.wp(50.0) : responsive.wp(80.0),
              height: responsive.dp(5.0),
              child: ElevatedButton(
                child: Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(
                    fontSize: responsive.dp(1.6),
                    color: Colors.white
                  )
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  primary: Colors.green
                ),
                onPressed: ()=> Navigator.pushReplacementNamed(context,'home-page'),
                
              ),
            )
          ]
        ),
      ),
    );
  }
}