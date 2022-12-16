import 'dart:async';
import 'package:cowchat/database/Task.dart';
import 'package:cowchat/database/TaskDao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'AppDatabase.g.dart';
@Database(version: 1, entities: [Task])
abstract class AppDatabase  extends FloorDatabase{
  TaskDao get taskDao;
}