import 'package:bankmenufood/models/order_sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'bankmenufood.db';
  final String nameTable = 'orderTable';
  final String columnid = 'id';
  final String columndesk = 'desk';
  final String columnidFood = 'idFood';
  final String columnnameFood = 'nameFood';
  final String columnprice = 'price';
  final String columnamount = 'amount';
  final String columnsum = 'sum';
  int varsion = 1;

  SQLiteHelper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $nameTable ($columnid INTEGER PRIMARY KEY, $columndesk TEXT, $columnidFood TEXT, $columnnameFood TEXT, $columnprice TEXT, $columnamount TEXT, $columnsum TEXT)'),
        version: varsion);
  }

  Future<Database> conectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Null> InsertDataToSQLite(OrderSQLModel model) async {
    Database database = await conectedDatabase();
    try {
      await database
          .insert(
            nameTable,
            model.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          )
          .then((value) => print('#####  Insert SQLite Success  #####'));
    } catch (e) {
      print('e insertSQLite ==>> ${e.toString()}');
    }
  }

  Future<List<OrderSQLModel>> readDataFromSQLite() async {
    Database database = await conectedDatabase();
    List<OrderSQLModel> models = List();
    List<Map<String, dynamic>> maps = await database.query(nameTable);
    for (var map in maps) {
      OrderSQLModel model = OrderSQLModel.fromJson(map);
      models.add(model);
    }
    return models;
  }

  Future<Null> deleteSQLitById(int id) async {
    Database database = await conectedDatabase();
    try {
      await database
          .delete(nameTable, where: '$columnid = $id')
          .then((value) => print('Detlet id = $id finish'));
    } catch (e) {}
  }

  Future<Null> deleatAllData()async{
    Database database = await conectedDatabase();
    try {
        await database.delete(nameTable);
    } catch (e) {
    }
  }

}
