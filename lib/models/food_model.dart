class FoodModel {
  String id;
  String category;
  String nameFood;
  String price;
  String detail;

  FoodModel({this.id, this.category, this.nameFood, this.price, this.detail});

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['Category'];
    nameFood = json['NameFood'];
    price = json['Price'];
    detail = json['Detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Category'] = this.category;
    data['NameFood'] = this.nameFood;
    data['Price'] = this.price;
    data['Detail'] = this.detail;
    return data;
  }
}
