import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_images/models/export_models.dart';
import 'package:app_images/pages/export_pages.dart';
import 'package:app_images/providers/export_providers.dart';
import 'package:app_images/utils/export_utils.dart';
import 'package:app_images/widgets/app_widgets.dart';

class ProductDataSearch extends SearchDelegate{

  @override
  String get searchFieldLabel=>'Search product';

  @override
  TextStyle get searchFieldStyle=>const TextStyle(
    fontSize: 18.0
  );

  @override
  List<Widget> buildActions(BuildContext context){
    if(query.isNotEmpty){
      return[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: (){
            query='';
          }
        ),
      ];
    }
    else{
      return[
        Container(
          padding: const EdgeInsets.all(10.0),
          child: const Icon(Icons.search),
        )
      ];
    }
  }
  
  //Back
  @override
  Widget buildLeading(BuildContext context){

    return IconButton(
      icon: const Icon(Icons.arrow_back), 
      onPressed: (){
        close(context,null);
      }
    );
  }
  
  @override
  Widget buildResults(BuildContext context){
    return _showResults(context);
  }
  
  @override
  Widget buildSuggestions(BuildContext context){
    return _showResults(context);
  }

  Widget _showResults(BuildContext context){
    final responsive=Responsive.of(context);
    final categoryProvider=Provider.of<CategoryProvider>(context);
    
    List<ProductModel> listResults=[];
    List<ProductModel> listSuggestions=[];
    List<ProductModel> listSearchResults=[];
    
    if(categoryProvider.getIndexCategory==0)
      { listSuggestions=listItems.where((items)=> items.ranking>=4.0).toList(); }
    else
      { listSuggestions=listItems.where((items)=> items.ranking>=4.0 && items.category==categoryProvider.getIndexCategory).toList(); }

    listSuggestions.sort((itemsA, itemsB) => itemsA.price>=itemsB.price? 0 : 1);
    
    if(categoryProvider.getIndexCategory==0)
      { listSearchResults=listItems.where((items)=> items.name.toUpperCase().contains(query.toUpperCase().trim())).toList(); }
    else
      { listSearchResults=listItems.where((items)=> items.name.toUpperCase().contains(query.toUpperCase().trim()) && items.category==categoryProvider.getIndexCategory).toList(); }
    
    listSearchResults.sort((itemsA, itemsB)=> itemsA.price>=itemsB.price? 0 : 1);

    query.isEmpty
      ? listResults=[]
      : listResults.addAll(listSearchResults);

    return _searchProductList(context,responsive,listResults);
  }

  Widget _searchProductList(BuildContext context, Responsive responsive, List<ProductModel> searchList){
    if(searchList.isEmpty) {return Container(); }
    else { return _searchWithResults(responsive, searchList, context); }
  }

  Widget _searchWithResults(Responsive responsive, List<ProductModel> searchList, BuildContext context){
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          SizedBox(height: responsive.dp(0.4)),
          query=='' ? Container(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              'Suggestions',
              style: TextStyle(
                fontSize: responsive.dp(1.8),
              ),
              textAlign: TextAlign.center,
            ),
          )
          : Text(
            'Results',
            style: TextStyle(
              fontSize: responsive.dp(1.8),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: responsive.dp(1.0)),
          Expanded(
           child: ListView.builder(
              padding: const EdgeInsets.all(0.2),
              itemCount: searchList.length,
              // itemExtent: responsive.dp(8.0),
              itemBuilder: (_,index){
                return Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Column(
                          children: <Widget>[
                            _viewItems(responsive,searchList,index,context),
                          ]
                        ),
                      )
                    ]
                  ),
                );
              }
            ),
         )
        ]
      ),
    );
  }

  Widget _viewItems(Responsive responsive, List<ProductModel> searchList, int index, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _imageItems(responsive, searchList, index),
        SizedBox(width: responsive.dp(1.0)),
        Expanded(
          child: _listItems(searchList,index,responsive,context),
        )
      ]
    );
  }

  Widget _imageItems(Responsive responsive, List searchList, int index){
    return Container(
      height: responsive.dp(8.0),
      width: responsive.dp(12.0),
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
          image: ExactAssetImage(
            searchList[index].image
          ),
          fit: BoxFit.cover,
        )
      ),
    );
  }

  Widget _listItems(List<ProductModel> searchList, int index, Responsive responsive, BuildContext context) {
    final productProvider=Provider.of<ProductProvider>(context);
    List<ProductModel> listProduct=[];
    int indexProduct=0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          searchList[index].name,
          style: TextStyle(
            fontSize: responsive.dp(1.4),
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: responsive.dp(0.5)),
        Text(
          '\$ ${formatNumberWithZeros(searchList[index].price)}',
          style: TextStyle(
            fontSize: responsive.dp(1.4),
            color: Colors.black54,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: responsive.dp(0.8)),
        Container(
          padding: const EdgeInsets.all(0),
          height: responsive.dp(3.0),
          child: ElevatedButton(
            child: detailsButton(responsive),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: Colors.white,
              side: const BorderSide(
                width: 0.5, 
                color: Colors.black
              ),
            ),
            onPressed: (){
              listProduct=listItems.where((items)=> items.id==int.parse(searchList[index].id.toString())).toList();
              
              productProvider.setListProduct=listProduct;  

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> 
                  DetailsProductPage(searchList[index].id,indexProduct)
                )
              );
            }
          ),
        ),
      ]
    );
  }
 
}