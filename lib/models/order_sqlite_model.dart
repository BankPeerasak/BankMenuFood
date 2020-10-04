class OrderSQLModel {
  int id;
  String desk;
  String idFood;
  String nameFood;
  String price;
  String amount;
  String sum;

  OrderSQLModel(
      {this.id,
      this.desk,
      this.idFood,
      this.nameFood,
      this.price,
      this.amount,
      this.sum});

  OrderSQLModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desk = json['desk'];
    idFood = json['idFood'];
    nameFood = json['nameFood'];
    price = json['price'];
    amount = json['amount'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['desk'] = this.desk;
    data['idFood'] = this.idFood;
    data['nameFood'] = this.nameFood;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['sum'] = this.sum;
    return data;
  }
}
