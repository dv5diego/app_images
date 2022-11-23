import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import 'package:app_images/models/export_models.dart';
import 'package:app_images/utils/export_utils.dart';
import 'package:app_images/providers/export_providers.dart';
import 'package:app_images/pages/export_pages.dart';
import 'package:app_images/search/product_data_search.dart';

class HomeProductPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);
    final categoryProvider=Provider.of<CategoryProvider>(context);
    final productProvider=Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: responsive.dp(0.0)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: responsive.dp(1.5)),
                      Row(
                        children: <Widget>[
                          SizedBox(width: responsive.dp(1.0)),
                          _buttonSearch(context,responsive)
                        ]
                      ),
                      SizedBox(height: responsive.dp(1.0)),
                      _titles(responsive,Constants.categoryTitle,2.0),
                      SizedBox(height: responsive.dp(2.0)),
                      _productCategoryList(responsive,categoryProvider,productProvider),
                      _titles(responsive,Constants.popularTitle,2.0),
                      SizedBox(height: responsive.dp(2.0)),
                      _popularProductList(responsive,context,productProvider),
                    ]
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget _buttonSearch(BuildContext context, Responsive responsive){
    return Container(
      width: responsive.isTablet? responsive.wp(90.0) : responsive.wp(84.0),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(
          Radius.circular(responsive.dp(2.0))
        ),
      ),
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Icon(
              Icons.search,
              color: Colors.black
            ),
            SizedBox(width: responsive.dp(3.0)),
            Text(
              Constants.searchButtonText,
              style: TextStyle(
                color: Colors.black87,
                fontSize: responsive.dp(1.8),
              ),
            ),
          ]
        ),
        onPressed: (){
          showSearch(
            context: context,
            delegate: ProductDataSearch(),
          );
        },
      ),
    );
  }

  Widget _titles(Responsive responsive, String title, double size){
    return Container(
      padding: const EdgeInsets.all(0),
      child:  Text(
        title,
        style: TextStyle(
          fontSize: responsive.dp(size),
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _productCategoryList(Responsive responsive, CategoryProvider categoryProvider, ProductProvider productProvider){
    return Container(
      color: Colors.white,
      height: responsive.dp(30.0),
      width: double.infinity, 
      child: ListView.builder(
        itemCount: listCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          EdgeInsets paddingHeader=EdgeInsets.only(
            left: responsive.dp(1.0), 
            right: responsive.dp(1.0), 
            top: responsive.dp(0.4),
            bottom: responsive.dp(2.5)
          );
          return Padding(
            padding: paddingHeader,
            child: InkWell(
              onTap: (){
                categoryProvider.setIndexCategory=listCategories[index].id;
                categoryProvider.setNameCategory=listCategories[index].description;
                productProvider.setSortList=false;
                productProvider.setFilterType=0;
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: const Duration(milliseconds: 400),
                    child: ProdutcCategoriesPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(responsive.dp(1.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      offset: const Offset(3.0,10.0),
                      blurRadius: responsive.dp(0.5)
                    )
                  ],
                  image: DecorationImage(
                    image: ExactAssetImage(
                      listCategories[index].image
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                width: responsive.dp(23.0),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF273A48),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(responsive.dp(1.0)),
                            bottomRight: Radius.circular(responsive.dp(1.0))
                          )
                        ),
                        height: responsive.dp(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              listCategories[index].description,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: responsive.dp(1.6)
                              ),
                            )
                          ],
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _popularProductList(Responsive responsive, BuildContext context, ProductProvider productProvider){
    List<ProductModel> productList=listItems.where((items)=> items.ranking>=4.0).toList();
    productList.sort((itemsA, itemsB)=> itemsA.ranking>=itemsB.ranking ? 0 : 1);
    
    EdgeInsets paddingHeader=EdgeInsets.only(
      left: responsive.dp(1.0), 
      right: responsive.dp(1.0), 
      top: responsive.dp(0.4),
      bottom: responsive.dp(6.5)
    );

    return Container(
      padding: const EdgeInsets.all(0),
      height: responsive.dp(33.0),
      width: double.infinity, 
      child: ListView.builder(
        itemCount: productList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              productProvider.setListProduct=productList;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> 
                  DetailsProductPage(productList[index].id,index)
                )
              );
            },
            child: Padding(
              padding: paddingHeader,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(responsive.dp(1.0)),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.2
                  ),
                ),
                width: responsive.dp(23.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _headerPopularProduct(responsive,productList,index),
                    SizedBox(height: responsive.dp(1.5)),
                    _bodyPopularProduct(productList,index,responsive,context),
                    SizedBox(height: responsive.dp(2.0)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _headerPopularProduct(Responsive responsive, List<ProductModel> productList, int index){
    return Expanded(
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0),
            height: responsive.dp(20.0),
            child: (productList[index].image!='')
              ? FadeInImage(
                placeholder: const AssetImage('assets/media/giphy.gif'),
                image: ExactAssetImage(productList[index].image),
                fit: BoxFit.contain
              )
              : const Image(
                  image: AssetImage('assets/media/no-image.png'),
                  fit: BoxFit.contain
                ),
          ),
          Positioned(
            right: responsive.dp(1.0),
            top: responsive.dp(1.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: responsive.dp(1.8),
                    ),
                    SizedBox(width: responsive.dp(0.4)),
                    Text(
                      productList[index].ranking.toString(),
                      style: TextStyle(
                        fontSize: responsive.dp(1.6),
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyPopularProduct(List<ProductModel> productList, int index, Responsive responsive, BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: responsive.dp(1.5)),
          child: Text(
            productList[index].name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: responsive.dp(1.4),
              color: Colors.black87,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: responsive.dp(1.5)),
          child: Text(
            '\$ ${formatNumberWithZeros(productList[index].price)}',
            style: TextStyle(
              fontSize: responsive.dp(1.8),
              color: Colors.black54,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ]
    );
  }

}