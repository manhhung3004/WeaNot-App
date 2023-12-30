import 'package:sqflite/sqflite.dart';
import 'package:weather_app/calender/task.dart';

class DBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDb() async{
    if(_db != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + "task.db";
      _db = await openDatabase(_path,version: _version,onCreate: (db,version){
        return db.execute(
          "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,note TEXT,isComplete INTEGER,date TEXT,startTime TEXT,endTime TEXT,color INTEGER,remind INTEGER,repeat TEXT)"
        );
      });
    }catch(ex){
      print(ex);
    }
  }
  static Future<int> insert(Task? task) async{
    print("insert fuction called");
    return await _db!.insert(_tableName, task!.toJson());
  }
}