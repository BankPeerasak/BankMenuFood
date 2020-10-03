import 'package:bankmenufood/utirity/my_constant.dart';
import 'package:flutter/material.dart';

class CategoryFood extends StatefulWidget {
  @override
  _CategoryFoodState createState() => _CategoryFoodState();
}

class _CategoryFoodState extends State<CategoryFood> {
  List<Widget> widgets = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createArray();
  }

  void createArray() {
    List<String> titles = MyConstant().categorys;
    List<String> paths = MyConstant().pathCategoryImages;

    int index = 0;
    for (var title in titles) {
      widgets.add(
        Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  child: Image.asset(paths[index]),
                ),
                Text(title),
              ],
            ),
          ),
        ),
      );

      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        children: widgets,
      ),
    );
  }
}
