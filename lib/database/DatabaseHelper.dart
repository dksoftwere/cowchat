import 'package:cowchat/database/AppDatabase.dart';

class DatabaseHelper{
  static const _databaseName = "AppDatabase.db";
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static late final $FloorAppDatabase _database;
  static var dao;
  Future<$FloorAppDatabase> get database async{
    if(_database !=null){
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async{
    return await $FloorAppDatabase
        .databaseBuilder(_databaseName)
        .build();
  }
}