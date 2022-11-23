// import 'package:app_images/providers/export_providers.dart';
import 'package:flutter/material.dart';

// import 'package:app_images/utils/constants.dart';
import 'package:app_images/utils/responsive.dart';

String formatZeros(double n1, double n2) {
  double n3=n1*n2;

  return n3.toStringAsFixed(2);
}

String formatNumberWithZeros(double n) {
  return n.toStringAsFixed(2);
}

void showSnackBar(BuildContext context, Responsive responsive, bool indicator, String message){
  final snackbar= SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontSize: responsive.dp(1.6)
      ),
    ),
    duration: const Duration(milliseconds: 1500),
    backgroundColor: indicator?Colors.black87:Colors.red[400],
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

//Aletras de acciones satisfactorias
void showSuccessfull(BuildContext context, String message){
  final responsive=Responsive.of(context);

  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(responsive.dp(1.0)))
        ),
        title: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: responsive.dp(4.0),
        ),
        content: Container(
          padding: const EdgeInsets.all(0),
          width: responsive.wp(12.0),
          child: Text(
            message,
            style: TextStyle(
              fontSize: responsive.dp(1.6),
              color: Colors.black,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Ok',
              style: TextStyle(
                fontSize: responsive.dp(1.6),
                color: Colors.black,
              ),
            ),
            onPressed: (){
              Navigator.pushReplacementNamed(context,'home-page');
            }
          )
        ],
      );
    }
  );
}

//Estructura base de Dialog de una alerta
void showBaseAlert(BuildContext context, String message, IconData icon, Color color){
  final responsive=Responsive.of(context);

  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(responsive.dp(1.0)))
        ),
        title: Icon(
          icon,
          color: color,
          size: responsive.dp(4.0),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: responsive.dp(1.6),
            color: Colors.black
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.black,
                fontSize: responsive.dp(1.6),
              ),
            ),
            onPressed: (){
              Navigator.of(context).pop();
            }
          )
        ],
      );
    }
  );
}

void showProgressIndicator(BuildContext context, String message){
  final responsive=Responsive.of(context);

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context){
      return AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(responsive.dp(1.0)))
        ),
        title: Container(
          height: responsive.dp(12.0),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0),
                height: responsive.dp(5.5),
                width: responsive.dp(5.5),
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  strokeWidth: 4.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(height: responsive.dp(1.4)),
              Text(
                message,
                style: TextStyle(
                  fontSize: responsive.dp(1.8),
                  color: Colors.white,
                  fontWeight: FontWeight.w700
                ),
              ),
            ]
          ),
        ),
      );
    }
  );
}