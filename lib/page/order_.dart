import 'package:bankmenufood/models/order_sqlite_model.dart';
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
      appBar: AppBar(
        title: Text(models[0].desk),
      ),
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) => Row(
          children: [
            Expanded(flex: 4,
              child: Text(models[index].nameFood),
            ),
            Expanded(flex: 1,
              child: Text(models[index].price),
            ),
            Expanded(flex: 1,
              child: Text(models[index].amount),
            ),
            Expanded(flex: 1,
              child: Text(models[index].sum),
            ),Expanded(child: IconButton(icon: Icon(Icons.delete), onPressed: null))
          ],
        ),
      ),
    );
  }
}
