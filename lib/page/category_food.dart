import 'package:bankmenufood/page/menu_food.dart';
import 'package:bankmenufood/utirity/my_constant.dart';
import 'package:flutter/material.dart';

class CategoryFood extends StatefulWidget {
  @override
  _CategoryFoodState createState() => _CategoryFoodState();
}

class _CategoryFoodState extends State<CategoryFood> {
  List<Widget> widgets = List();
  List<String> titles = MyConstant().categorys;
    List<String> paths = MyConstant().pathCategoryImages;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createArray();
  }

  void createArray() {
    
    int index = 0;
    for (var title in titles) {
      widgets.add(
        buildWidget(index, paths, title),
      );

      index++;
    }
  }

  GestureDetector buildWidget(int index, List<String> paths, String title) {
    return GestureDetector(
      onTap: () {
        print('index = $index');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuFood(category: titles[index],),
            ));
      },
      child: Card(
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
