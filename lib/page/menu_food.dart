import 'dart:convert';

import 'package:bankmenufood/models/food_model.dart';
import 'package:bankmenufood/utirity/my_constant.dart';
import 'package:bankmenufood/utirity/my_style.dart';
import 'package:bankmenufood/utirity/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MenuFood extends StatefulWidget {
  final String category;
  MenuFood({Key key, this.category}) : super(key: key);
  @override
  _MenuFoodState createState() => _MenuFoodState();
}

class _MenuFoodState extends State<MenuFood> {
  String category, chooseDesk;
  List<String> desks = MyConstant().nameDesks;
  List<FoodModel> foodModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = widget.category;
    readData();
  }

  Future<Null> readData() async {
    String urlAPI =
        '${MyConstant().domain}/letrang2/getFoodWhereCatigoryBank.php?isAdd=true&Category=$category';
    //  print('urlAPI = $urlAPI');
    var response = await Dio().get(urlAPI);
    // print('res = $response');
    var result = json.decode(response.data);
    // print('result = $result');
    for (var json in result) {
      FoodModel model = FoodModel.fromJson(json);
      setState(() {
        foodModels.add(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Column(
        children: [
          buildDropdownButton(),
          buildExpanded(),
        ],
      ),
    );
  }

  Expanded buildExpanded() => Expanded(
        child: foodModels.length == 0
            ? MyStyle().showProgress()
            : ListView.builder(
                itemCount: foodModels.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (chooseDesk == null) {
                            print('Dot Choose Desk');
                            normalDialog(context, 'กรุณาเลือกโต๊ะก่อนค่ะ');
                          } else {
                            print('You Chick ${foodModels[index].nameFood}');
                            confirmFooDialog(foodModels[index]);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              foodModels[index].nameFood,
                              style: MyStyle().titleStyeH1(),
                            ),
                            Text(
                              foodModels[index].price,
                              style: MyStyle().titleStyeH2(),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
      );

  Row buildDropdownButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            items: desks
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                chooseDesk = value;
              });
            },
            value: chooseDesk,
            hint: Text('โปรดเลือกโต๊ะ'),
          ),
        ],
      );

  Future<Null> confirmFooDialog(FoodModel foodModel) async {
    showDialog(
      context: context,
      builder: (context) {
        int amount = 1;
        return StatefulBuilder(builder: (context, setState) {
          return SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(foodModel.nameFood),
              Text(foodModel.price),
            ],
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.add_circle_outline), onPressed: () {
                      setState(() {
                        amount++;
                        print('amout = $amount');
                      });
                    },),
                Text('$amount'),
                IconButton(
                    icon: Icon(Icons.remove_circle_outline), onPressed: () {
                      if (amount == 1 ) {
                        amount = 1;
                        
                      } else {
                       setState(() {
                        amount--;
                        print('amout = $amount');
                      });
                      }
                    },),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: null,
                  child: Text('OK'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('NO'),
                ),
              ],
            ),
          ],
        );
        },);
      },
    );
  }
}
