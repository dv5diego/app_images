import 'package:flutter/material.dart';
import 'package:app_images/utils/responsive.dart';
import 'package:provider/provider.dart';

import 'package:app_images/widgets/app_widgets.dart';
import 'package:app_images/providers/export_providers.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    final responsive=Responsive.of(context);
    final productProvider=Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
          context,
          responsive.wp(5.0),
          responsive.wp(4.5),
          responsive.dp(0.2),
          responsive.dp(0.8),
          responsive.dp(3.0),
          '',
          responsive.dp(1.5),
          true,
          productProvider
      ),
    );
  }
}