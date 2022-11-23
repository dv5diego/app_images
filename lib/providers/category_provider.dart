import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier{

  int _indexCategory=0;
  String _nameCategory='';


  set setIndexCategory(int value){
    _indexCategory=value;
  }

  int get getIndexCategory{
    return _indexCategory;
  }

  set setNameCategory(String value){
    _nameCategory=value;
  }

  String get getNameCategory{
    return _nameCategory;
  }

}