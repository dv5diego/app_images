import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_images/models/export_models.dart';
import 'package:app_images/providers/export_providers.dart';
import 'package:app_images/utils/export_utils.dart';

class DetailsProductPage extends StatelessWidget {
  final int idProduct;
  final int index;

  const DetailsProductPage(this.idProduct, this.index);

  @override
  Widget build(BuildContext context) {
    final responsive=Responsive.of(context);
    final productProvider=Provider.of<ProductProvider>(context);

    final List<ProductModel> newListProduct=productProvider.getListProduct;
    
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '', 
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: responsive.wp(100.0),
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: responsive.dp(0.5)),
                  _productImage(responsive,context,newListProduct,productProvider),
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: responsive.wp(85.0),
                    height: responsive.dp(8.0),
                    child:  null
                  ),
                  SizedBox(height: responsive.dp(1.5)),
                  _productDetails(responsive,newListProduct,productProvider),
                  SizedBox(height: responsive.dp(1.5)),
                  _productDescription(responsive,newListProduct),
                  SizedBox(height: responsive.dp(3.8))
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  Widget _productImage(Responsive responsive, BuildContext context, List<ProductModel> newListProduct, ProductProvider productProvider){
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          height: responsive.dp(35.0),
          child: 
            newListProduct[index].image.isNotEmpty
            ? Image.asset(
              newListProduct[index].image,
              fit: BoxFit.fill,
            )
            : const Image(
              image: AssetImage('assets/media/no-image.png'),
              fit: BoxFit.fill
            ),
        ),
        Positioned(
          top: responsive.dp(2.0),
          right: responsive.dp(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _action(Icons.favorite,responsive,context,productProvider,newListProduct),
            ]
          )
        ),
      ]
    );
  }

  Widget _productDetails(Responsive responsive, List<ProductModel> newListProduct, ProductProvider productProvider){
    return Container(
      padding: const EdgeInsets.all(0),
      width: responsive.wp(85.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${newListProduct[index].name} - \$ ${formatNumberWithZeros(newListProduct[index].price)}',
                        style: TextStyle(
                          fontSize: responsive.dp(2.0),
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDescription(Responsive responsive, List<ProductModel> newListProduct){
    return Container(
      padding: const EdgeInsets.all(0),
      width: responsive.wp(85.0),
      child: Text(
        newListProduct[index].description,
        style: TextStyle(
          color: Colors.black,
          fontSize: responsive.dp(1.8),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _action(IconData icon, Responsive responsive, BuildContext context, ProductProvider productProvider, List<ProductModel> newListProduct){
    bool existProductInWitshList=productProvider.getWishListProduct.entries.where((element) => element.value.id==idProduct.toString()).isEmpty? false : true;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF273A48),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(responsive.dp(3.0)),
          bottomRight: Radius.circular(responsive.dp(3.0)),
          topLeft: Radius.circular(responsive.dp(3.0)),
          topRight: Radius.circular(responsive.dp(3.0)),
        )
      ),
      child:
        IconButton(
          icon: Icon(icon),
          iconSize: responsive.dp(4.0),
          color: existProductInWitshList? const Color(0xFFF4392D) : Colors.grey,
          onPressed: (){
            if(existProductInWitshList){
              productProvider.removeItemWishList(idProduct.toString());
              productProvider.setExistInWishList=false;
              showSnackBar(context,responsive,false,'It was removed from the Wishlist.');
            }
            else{
              productProvider.setExistInWishList=true;
              productProvider.addUpdateWishList(
                idProduct.toString(), newListProduct[index].name, newListProduct[index].image,
                newListProduct[index].amount,newListProduct[index].price,
                productProvider.getExistInWishList
              );
              showSnackBar(context,responsive,true,'It was added to the Wishlist.');
            }
          }
        ),
    );
  }

}