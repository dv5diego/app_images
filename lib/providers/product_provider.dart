import 'package:flutter/material.dart';

import 'package:app_images/models/export_models.dart';

class ProductProvider with ChangeNotifier{

  bool _buttonStatusAdd=false;
  int _selectedIndex=0;
  final Map<dynamic,RankingProductModel> _listProductRanking={};
  bool _existRanking=false;
  Map<dynamic,WishListModel> _wishList={};
  bool _existWish=false;
  bool _sortList=false;
  int _filterType=0;
  int _groupValueFilter=0;
  List<ProductModel> _productList=[];

  //Getters
  bool get getButtonStatus{
    return _buttonStatusAdd;
  }

  int get getSelectIndex{
    return _selectedIndex;
  }

  Map<dynamic,RankingProductModel> get getListProductRanking{
    return {..._listProductRanking};
  }

  List<ProductModel> get getListProduct{
    return _productList;
  }

  bool get getExistInWishList{
    return _existWish;
  }

  bool get getProductRanking{
    return _existRanking;
  }

  Map<dynamic,WishListModel> get getWishListProduct{
    return {..._wishList};
  }

  bool get getSortList{
    return _sortList; 
  }

  int get getFilterType{
    return _filterType;
  }

  int get getGroupValueFilter{
    return _groupValueFilter;
  }

  //Setters
  set setButtonStatus(bool value){
    _buttonStatusAdd=value;
    notifyListeners();
  }

  set setListProduct(List<ProductModel> value){
    _productList=value;
    notifyListeners();
  }

  void selectIndex(int value){
    _selectedIndex=value;
    notifyListeners();
  }

  void addUpdateRanking(String idProduct, int valueUser, bool valueStart){
    if(_listProductRanking.containsKey(idProduct)){
      _listProductRanking.update(idProduct, (value)=>RankingProductModel(
          id: idProduct,
          user: value.user,
          start: value.start,
        )
      );
    }
    else{
      _listProductRanking.putIfAbsent(idProduct, ()=>RankingProductModel(
          id: idProduct,
          user: valueUser,
          start: valueStart,
        )
      );
    }
    notifyListeners();
  }

  set setProductRanking(bool value){
    _existRanking=value;
  }

  void removeItemRanking(String idItem){
    _listProductRanking.remove(idItem);
    notifyListeners();
  }

  void addUpdateWishList(String idProduct, String valueProduct, String valueImage, int valueAmount, double valueTotal, bool valueHeart){
    if(_wishList.containsKey(idProduct)){
      _wishList.update(idProduct, (value)=>WishListModel(
          id: idProduct,
          product: value.product,
          image: value.image,
          amount: value.amount,
          totalPrice: value.totalPrice,
          heart: value.heart
        )
      );
    }
    else{
      _wishList.putIfAbsent(idProduct, ()=>WishListModel(
          id: idProduct,
          product: valueProduct,
          image: valueImage,
          amount: valueAmount,
          totalPrice: valueTotal,
          heart: valueHeart
        )
      );
    }
    notifyListeners();
  }

  set setWishListProduct(Map<dynamic,WishListModel> value){
    _wishList=value;
    notifyListeners();
  }

  void removeItemWishList(String idItem){
    _wishList.remove(idItem);
    notifyListeners();
  }

  set setSortList(bool value){
    _sortList=value;
    notifyListeners();
  }

  set setFilterType(int value){
    _filterType=value;
    notifyListeners();
  }

  set setGroupValueFilter(int value){
    _groupValueFilter=value;
    notifyListeners();
  }
  
  set setExistInWishList(bool value){
    _existWish=value;
    notifyListeners();
  }
}