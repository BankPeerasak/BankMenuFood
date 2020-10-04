import 'package:bankmenufood/models/order_sqlite_model.dart';
import 'package:bankmenufood/page/category_food.dart';
import 'package:bankmenufood/utirity/my_constant.dart';
import 'package:bankmenufood/utirity/my_style.dart';
import 'package:bankmenufood/utirity/normal_dialog.dart';
import 'package:bankmenufood/utirity/sqlite_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  final List<OrderSQLModel> models;
  Order({Key key, this.models}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<OrderSQLModel> models;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    models = widget.models;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => processOrderToServer(),
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(
        title: Text(models[0].desk),
      ),
      body: Column(
        children: [
          buildRow(),
          buildListView(),
        ],
      ),
    );
  }

  Container buildRow() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade400),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            buildExpanded('ชื่ออาหาร', 4),
            buildExpanded('ราคา', 1),
            buildExpanded('จำนวน', 1),
            buildExpanded('รวม', 1),
            buildExpanded('ลบ', 1),
          ],
        ),
      ),
    );
  }

  Expanded buildExpanded(String title, int i) => Expanded(
        flex: i,
        child: Text(
          title,
          style: MyStyle().titleStyeH3(),
        ),
      );

  Expanded buildListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) => Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(models[index].nameFood),
            ),
            Expanded(
              flex: 1,
              child: Text(models[index].price),
            ),
            Expanded(
              flex: 1,
              child: Text(models[index].amount),
            ),
            Expanded(
              flex: 1,
              child: Text(models[index].sum),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteOrder(models[index].id),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> deleteOrder(int id) async {
    await SQLiteHelper().deleteSQLitById(id).then((value) async {
      models.clear();
      var object = await SQLiteHelper().readDataFromSQLite();
      if (object.length == 0) {
        Navigator.pop(context);
      } else {
        setState(() {
          models = object;
        });
      }
    });
  }

  Future<Null> processOrderToServer() async {
    String desk = models[0].desk;
    String idFood = changeIdFood();
    String nameFood = changeNameFood();
    String price = changePrice();
    String amount = changeAmount();
    String sum = changeSum();

    String urlAPI =
        '${MyConstant().domain}/letrang2/addOrder.php?isAdd=true&desk=$desk&idFood=$idFood&nameFood=$nameFood&price=$price&amount=$amount&sum=$sum';

    var response = await Dio().get(urlAPI);
    if (response.toString() == 'true') {
      print('Sucess Order');
      await SQLiteHelper()
          .deleatAllData()
          .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryFood(),
              ),
              (route) => false));
    } else {
      normalDialog(context, 'Please Try Agains ? Have Problum');
    }
  }

  String changeIdFood() {
    List<String> strings = List();
    for (var model in models) {
      strings.add(model.idFood);
    }
    return strings.toString();
  }

  String changeNameFood() {
    List<String> strings = List();
    for (var model in models) {
      strings.add(model.nameFood);
    }
    return strings.toString();
  }

  String changePrice() {
    List<String> strings = List();
    for (var model in models) {
      strings.add(model.price);
    }
    return strings.toString();
  }

  String changeAmount() {
    List<String> strings = List();
    for (var model in models) {
      strings.add(model.amount);
    }
    return strings.toString();
  }

  String changeSum() {
    List<String> strings = List();
    for (var model in models) {
      strings.add(model.sum);
    }
    return strings.toString();
  }
}
