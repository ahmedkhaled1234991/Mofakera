import 'package:mofakera/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;

class Note{

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    io.Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,"todolist.db");
    var mydb=await openDatabase(path,version: 1,onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db,int version) async {
    await db.execute("CREATE TABLE todo (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,description TEXT NOT NULL,title TEXT NOT NULL, date TEXT NOT NULL, color TEXT NOT NULL, done TEXT NOT NULL)");
    print("Todo Table Created");
  }

  Future <int> insertdb(Map<String,dynamic> data)async{
    Database? db_clint=await db;
    var reselt =await db_clint!.insert("todo", data);
    return reselt;
  }

  Future <int> deletetodo(int id)async{
    Database? db_clint=await db;
    var reselt =await db_clint!.rawUpdate("DELETE FROM todo WHERE id='$id'");
    return reselt;
  }

  Future <int> updatetodo(String note,int id)async{
    Database? db_clint=await db;
    var reselt =await db_clint!.rawUpdate("UPDATE todo SET note='$note' WHERE id='$id'");
    return reselt;
  }

  Future<List<TodoModel>> getdata() async{
    Database? db_clint=await db;
    var reselt =await db_clint!.query("todo");
    List<TodoModel>list=[];
    for(var i in reselt){
      TodoModel model = TodoModel(i["id"], i["description"], i["title"], i["date"], i["color"], i["done"]);
      list.add(model);
    }
    return list;
  }

  Future <List>getSingleRow(int id) async{
    Database? db_clint=await db;
    var reselt =await db_clint!.query("todo",where: 'id="$id"');
    return reselt;
  }
}