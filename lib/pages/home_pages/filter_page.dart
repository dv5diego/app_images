import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_images/providers/export_providers.dart';
import 'package:app_images/utils/responsive.dart';
import 'package:app_images/models/export_models.dart';
import 'package:app_images/utils/records.dart';

class FilterProductPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);
    final productProvider=Provider.of<ProductProvider>(context);
    final categoryProvider=Provider.of<CategoryProvider>(context);

    int category=categoryProvider.getIndexCategory;
    int groupValue=0;

    return Theme(
      data: ThemeData().copyWith(
        //coloca en color transparente todas las divisiones de la pantalla
        dividerColor: Colors.transparent
      ),
      child: Scaffold(
        backgroundColor: Colors.white, //aplica para toda la pantalla, incluye persistentFooterButtons
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Filters', 
              style: TextStyle(
                color: Colors.black,
                fontSize: responsive.dp(2.0)
              )
            )
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              width: responsive.isTablet? responsive.dp(80.0) : responsive.wp(94.0),
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Radio(
                        value: productProvider.getFilterType==0? 0 : 1,
                        groupValue: groupValue,
                        activeColor: Colors.black,
                        onChanged: (value){
                          productProvider.setFilterType=value==0? 1 : 0;
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Sort by price from highest to lowest.',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: responsive.dp(1.4),
                            color: Colors.black,
                          ),
                        ),
                        onPressed: (){
                          productProvider.setFilterType=0;
                        },
                      ),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Radio(
                        value: productProvider.getFilterType==0? 1 : 0,
                        groupValue: groupValue,
                        activeColor: Colors.black,
                        onChanged: (value){
                          productProvider.setFilterType=value==0? 0 : 1;
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Sort by price from lowest to highest.',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: responsive.dp(1.4),
                            color: Colors.black,
                          ),
                        ),
                        onPressed: (){
                          productProvider.setFilterType=1;
                        },
                      ),
                    ]
                  ),
                ]
              ),
            ),
          )
        ),
        persistentFooterButtons: <Widget>[
          _buttonsFilter(responsive,context,productProvider,category)
        ],
      ),
    );
  }

  Widget _buttonsFilter(Responsive responsive, BuildContext context, ProductProvider productProvider, int category){
    return Container(
      width: responsive.wp(100.0),
      height: responsive.dp(7.0),
      padding: const EdgeInsets.only(bottom: 0.0),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _cancelFilter(responsive, context),
          _applyFilter(responsive, category, productProvider, context),
        ]
      ),
    );
  }

  Widget _cancelFilter(Responsive responsive, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: responsive.isTablet? responsive.wp(30.0) : responsive.wp(35.0),
      child: ElevatedButton(
        child: Text(
          'Cancel',
          style: TextStyle(
            fontSize: responsive.dp(1.6),
            color: Colors.green,
            fontWeight: FontWeight.bold
          )
        ),
        style: ElevatedButton.styleFrom( 
          primary: Colors.white,
          elevation: 1.0,
          side: BorderSide(
            color: Colors.green,
            width: responsive.dp(0.1)
          )
        ),
        onPressed: ()=> Navigator.pop(context)
      ),
    );
  }

  Widget _applyFilter(Responsive responsive, int category, ProductProvider productProvider, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: responsive.isTablet? responsive.wp(30.0) : responsive.wp(35.0),
      child: ElevatedButton(
        child: Text(
          'Apply filters',
          style: TextStyle(
            fontSize: responsive.dp(1.6),
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
        style: ElevatedButton.styleFrom( 
          primary: Colors.green,
          elevation: 1.0,
        ),
        onPressed: (){
          List<ProductModel> listItemsByCategory=listItems.where((items)=> items.category==category).toList();
          productProvider.setSortList=productProvider.getFilterType==0? false : true;
                  
          if(productProvider.getSortList) { listItemsByCategory.sort((itemsA, itemsB)=> itemsA.price<=itemsB.price? 0 : 1); }
          else { listItemsByCategory.sort((itemsA, itemsB)=> itemsA.price>=itemsB.price? 0 : 1); }
          
          Navigator.of(context).pop();
        }
      ),
    );
  }

}