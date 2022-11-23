import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_images/models/product_model.dart';
import 'package:app_images/providers/export_providers.dart';
import 'package:app_images/utils/export_utils.dart';
import 'package:app_images/pages/export_pages.dart';
import 'package:app_images/widgets/app_widgets.dart';

class ProdutcCategoriesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);
    final categoryProvider=Provider.of<CategoryProvider>(context);
    final productProvider=Provider.of<ProductProvider>(context);

    return Theme(
      data: ThemeData().copyWith(
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarWidget(
          context,            //BuildContext
          responsive.wp(5.0), //width
          responsive.dp(4.5), //height
          responsive.dp(0.2), //pTop
          responsive.dp(0.8), //pRight
          responsive.dp(3.0), //sizeIcon
          categoryProvider.getNameCategory, //title
          responsive.dp(1.5), //sizeText
          true,                //arrowVisibility
          productProvider     //ProductProvider
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: responsive.dp(2.0)),
                      _productList(responsive,context,categoryProvider),
                    ]
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget _productList(Responsive responsive, BuildContext context, CategoryProvider categoryProvider){
    final productProvider=Provider.of<ProductProvider>(context);
    List<ProductModel> listItemsByCategory=listItems.where((items)=> items.category==categoryProvider.getIndexCategory).toList();
   
    if(productProvider.getSortList)
      { listItemsByCategory.sort((itemsA, itemsB)=> itemsA.price<=itemsB.price? 0 : 1); }
    else 
      { listItemsByCategory.sort((itemsA, itemsB)=> itemsA.price>=itemsB.price? 0 : 1); }
    
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: responsive.dp(0.5),
        mainAxisSpacing: responsive.dp(0.5),
        childAspectRatio: 0.8,
        padding: EdgeInsets.all(responsive.dp(0.5)),
        children: List.generate(
          listItemsByCategory.length, (index){
            return InkWell(
              onTap: (){
                productProvider.setListProduct=listItemsByCategory;
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> 
                    DetailsProductPage(listItemsByCategory[index].id,index)
                  )
                );
              },
              child: Card(
                clipBehavior: Clip.none,
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: (listItemsByCategory[index].image.isNotEmpty)
                          ? FadeInImage(
                            placeholder: const AssetImage('assets/media/giphy.gif'),
                            image: ExactAssetImage(listItemsByCategory[index].image),
                            fit: BoxFit.fill
                          )
                          : const Image(
                              image: AssetImage('assets/media/no-image.png'),
                              fit: BoxFit.fill
                            ),
                      ),
                    ),
                    SizedBox(height: responsive.dp(1.0)),
                    Container(
                      padding: EdgeInsets.only(left: responsive.dp(1.0)),
                      child: Text(
                        listItemsByCategory[index].name,
                        style: TextStyle(
                          fontSize: responsive.dp(1.4),
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: responsive.dp(0.2)),
                    Container(
                      padding: EdgeInsets.only(left: responsive.dp(1.0)),
                      child: Text(
                        '\$ ${formatNumberWithZeros(listItemsByCategory[index].price)}',
                        style: TextStyle(
                          fontSize: responsive.dp(1.8),
                          color: Colors.black54,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: responsive.dp(2.0)),
                  ]
                )
              ),
            );
          }
        ),
      ),
    );
  }

}