import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_images/pages/export_pages.dart';
import 'package:app_images/search/product_data_search.dart';
import 'package:app_images/providers/export_providers.dart';
import 'package:app_images/utils/export_utils.dart';
import 'package:app_images/models/export_models.dart';


appBarWidget(
  BuildContext context, double width, double height, double pTop, double pRight, double sizeIcon, String title, double sizeText, 
  bool arrowVisibility, ProductProvider productProvider){

  final responsive=Responsive.of(context);
  final categoryProvider=Provider.of<CategoryProvider>(context, listen: true);
  Color colorCategory=Colors.white;

  List<CategoryProductModel> listCategory=listCategories.where((items)=> items.id==categoryProvider.getIndexCategory).toList();

  colorCategory=listCategory.where((element) => element.id==categoryProvider.getIndexCategory).first.color;
  
  return PreferredSize(
    preferredSize: Size(width,height),
    child: AppBar(
      elevation: 0.0,
      backgroundColor: colorCategory,
      title: Text(
        title,
        style: TextStyle(
          fontSize: responsive.dp(2.0),
          color: Colors.black
        ),
      ),
      leading: categoryProvider.getIndexCategory!=0
      ? IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: (){
          categoryProvider.setIndexCategory=0;
          Navigator.pop(context);
        }
      )
      : null,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      automaticallyImplyLeading: arrowVisibility,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt),
          color: Colors.blue[700],
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> FilterProductPage()));
          }
        ),
        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: (){
            showSearch(
              context: context,
              delegate: ProductDataSearch(),
            );
          }
        ),
      ],
    ),
  );
}

Widget searchProductsWidget(BuildContext context, Responsive responsive, int counterItems){
  return Stack(
    clipBehavior: Clip.none,
    children: <Widget>[
      Positioned(
        top: responsive.dp(2.0),
        right: responsive.dp(2.0),
        child: Container(
          padding: EdgeInsets.all(responsive.dp(0.1)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsive.dp(8.0)),
            color: counterItems>0?Colors.red:Colors.white,
          ),
          child: Text(
            counterItems>0?counterItems.toString():'',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: responsive.dp(2.0),
            ),
          ),
        ),
      ),
    ]
  );
}

Widget detailsButton(Responsive responsive){
  return Text(
    'VIEW',
    style: TextStyle(
      fontSize: responsive.dp(1.6),
      color: Colors.green,
    ),
  );
}