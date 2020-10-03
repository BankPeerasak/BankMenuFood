import 'package:bankmenufood/page/category_food.dart';
import 'package:flutter/material.dart';


main()=>runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryFood(),
    );
  }
}