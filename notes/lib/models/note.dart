import 'package:isar/isar.dart';

part 'note.g.dart';

@Collection()
class Note{
  Id id = Isar.autoIncrement;
  late String title;
  late String data ;
}

@Collection()
class AppThemeMode{
  Id id = 0;
  late bool isDarkMode ; 
}