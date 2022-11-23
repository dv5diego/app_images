import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_images/models/export_models.dart';
import 'package:app_images/utils/export_utils.dart';
import 'package:app_images/pages/export_pages.dart';
import 'package:app_images/providers/export_providers.dart';

class WishListPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);
    final productProvider=Provider.of<ProductProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'WishList', 
          style: TextStyle(
            color: Colors.black,
            fontSize: responsive.dp(2.0),
          )
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: productProvider.getWishListProduct.isNotEmpty
        ? _wishListFull(responsive,productProvider,context)
        : _emptyWishList(responsive,context,productProvider)
      )
    );
  }

  Widget _wishListFull(Responsive responsive, ProductProvider productProvider, BuildContext context){
    return Container(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: responsive.dp(1.0)),
            _wishList(context,responsive,productProvider,productProvider.getWishListProduct),
          ]
        ),
      ),
    );
  }

  Widget _emptyWishList(Responsive responsive, BuildContext context, ProductProvider productProvider){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    size: responsive.dp(5.0),
                    color: Colors.red,
                  ),
                  SizedBox(height: responsive.dp(1.0)),
                  Text(
                    '¡Your WishList is empty!',
                    style: TextStyle(
                      fontSize: responsive.dp(1.6),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _wishList(BuildContext context, Responsive responsive, ProductProvider productProvider, Map<dynamic, WishListModel> mapWishList){
    List<ProductModel> listProduct=[];
    int indexProduct=0;
    
    return Column(
      children: <Widget>[
        for (var item in mapWishList.values)
          Card(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    listProduct=listItems.where((items)=> items.id==int.parse(item.id)).toList();
                    
                    productProvider.setListProduct=listProduct;
                    
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> 
                          DetailsProductPage(int.parse(item.id),indexProduct)
                        )
                      );
                  },
                  child: ListTile(
                      trailing: _removeItem(responsive,item.id,productProvider),
                      title: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: responsive.dp(8.0),
                                width: responsive.dp(9.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(70),
                                      offset: const Offset(2.0,2.0),
                                      blurRadius: 2.0
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(responsive.dp(1.0))
                                  ),
                                  image: DecorationImage(
                                    image: item.image.isEmpty
                                      ? const AssetImage('assets/media/no-image.png')
                                      : ExactAssetImage(item.image),
                                    fit: BoxFit.fill,
                                  )
                                ),
                              ),
                              SizedBox(width: responsive.dp(1.0)),
                              _productData(item,responsive),
                            ]
                          ),
                        ]
                      )
                    ),
                ),
              ]
            )
          ),
      ]
    );
  }

  Widget _productData(WishListModel item, Responsive responsive) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: responsive.dp(1.0)),
          Text(
            item.product,
            style: TextStyle(
              fontSize: responsive.dp(1.6),
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: responsive.dp(1.0)),
          Text(
            '\$ ${formatNumberWithZeros(item.amount*item.totalPrice)}',
            style: TextStyle(
              fontSize: responsive.dp(1.6),
              color: Colors.black54,
              fontWeight: FontWeight.bold
            ),
          ),
        ]
      ),
    );
  }

  Widget _removeItem(Responsive responsive, String idItem, ProductProvider productProvider){
    return IconButton(
      icon: Icon(
        Icons.delete,
        size: responsive.dp(2.5),
        color: Colors.black87
      ),
      onPressed: (){
        productProvider.removeItemWishList(idItem);
      },
    );
  }
  
}