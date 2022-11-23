import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:app_images/utils/export_utils.dart';
import 'package:app_images/providers/export_providers.dart';
import 'package:app_images/pages/export_pages.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productProvider=Provider.of<ProductProvider>(context);

    final List<Widget> widgetOptionsBar=<Widget>[
      HomeProductPage(),
      WishListPage()
    ];

    Future<bool> onWillPop() async{
      return false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: widgetOptionsBar.elementAt(productProvider.getSelectIndex), 
        bottomNavigationBar: _CurvedNavigatonBarHome(),
      ),
    );
  }

}

class _CurvedNavigatonBarHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);
    final productProvider=Provider.of<ProductProvider>(context);

    return CurvedNavigationBar(
      height: responsive.hp(6.0),
      items: [
        Icon(Icons.home, size: responsive.dp(3.0)),
        Icon(Icons.favorite, size: responsive.dp(3.0))
      ],
      color: const Color.fromRGBO(41,128,185,1.0),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeOut,
      animationDuration: const Duration(milliseconds: 100),
      index: productProvider.getSelectIndex,
      onTap: productProvider.selectIndex,
      letIndexChange: (index)=> true, 
    );
  }

}