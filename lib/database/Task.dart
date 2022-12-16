import 'package:floor/floor.dart';

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
   int id;

   String name;
  Task(this.id, this.name);
}