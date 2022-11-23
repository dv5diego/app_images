import 'package:flutter/material.dart';

import 'package:app_images/utils/responsive.dart';

BoxDecoration boxDecorationWidget(Responsive responsive){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(responsive.dp(1.0)),
    border: Border.all(
      color: Colors.black,
      width: 0.2
    ),
  );
}

OutlineInputBorder outlineInputBorderWidget(Responsive responsive){
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.black,
      width: 0.2
    ),
    borderRadius: BorderRadius.circular(responsive.dp(1.0)),
  );
}

UnderlineInputBorder underlineInputBorderWidget(Color color){
  return UnderlineInputBorder(
    borderSide: BorderSide(color: color),
  );
}
