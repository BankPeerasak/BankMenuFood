import 'package:flutter/material.dart';

class MenuFood extends StatefulWidget {
  final String category;
  MenuFood({Key key, this.category}) : super(key: key);
  @override
  _MenuFoodState createState() => _MenuFoodState();
}

class _MenuFoodState extends State<MenuFood> {
  String category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Column(
        children: [buildDropdownButton()],
      ),
    );
  }

  DropdownButton buildDropdownButton() => DropdownButton(items: null, onChanged: null);
}
