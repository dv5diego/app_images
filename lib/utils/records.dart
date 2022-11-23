import 'package:app_images/models/export_models.dart';
import 'package:flutter/material.dart';

final List<ProductModel> listItems=[
  ProductModel(
    id: 1,
    name: 'Watch 1',
    image: 'assets/watches/watch1.jpg',
    description: 'watch 1',
    price: 180,
    amount: 1,
    ranking: 4.0,
    category: 1
  ),
  ProductModel(
    id: 2,
    name: 'Watch 2',
    image: 'assets/watches/watch2.jpg',
    description: 'watch 2',
    price: 169.90,
    amount: 1,
    ranking: 4.0,
    category: 1
  ),
  ProductModel(
    id: 3,
    name: 'Watch 3',
    image: 'assets/watches/watch3.jpg',
    description: 'watch 3',
    price: 280.90,
    amount: 1,
    ranking: 3.7,
    category: 1
  ),
  ProductModel(
    id: 4,
    name: 'keyboard 1',
    image: 'assets/keyboards/kb1.jpg',
    description: 'keyboard 1',
    price: 989.90,
    amount: 1,
    ranking: 5.0,
    category: 2
  ),
  ProductModel(
    id: 5,
    name: 'keyboard 2',
    image: 'assets/keyboards/kb2.jpg',
    description: 'keyboard 2',
    price: 1100,
    amount: 1,
    ranking: 3.0,
    category: 2
  ),
  ProductModel(
    id: 6,
    name: 'keyboard 3',
    image: 'assets/keyboards/kb3.jpg',
    description: 'keyboard 3',
    price: 750.50,
    amount: 1,
    ranking: 3.2,
    category: 2
  ),
  ProductModel(
    id: 7,
    name: 'keyboard 4',
    image: 'assets/keyboards/kb4.jpg',
    description: 'keyboard 4',
    price: 1400,
    amount: 1,
    ranking: 3.0,
    category: 2
  )
];

final List<CategoryProductModel> listCategories=[
  CategoryProductModel(
    id: 1,
    image: 'assets/watches/wp.jpg',
    country: 'PERU',
    description: 'Watches',
    color: Colors.green
  ),
  CategoryProductModel(
    id: 2,
    image: 'assets/keyboards/kbp.jpg',
    country: 'PERU',
    description: 'Keyboards',
    color: Colors.grey
  ),
];
