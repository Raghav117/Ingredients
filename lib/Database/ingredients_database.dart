import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class IngredientDb{

  static final IngredientDb _ingredientDb = IngredientDb._internal();
  IngredientDb._internal();

  factory IngredientDb(){
    return _ingredientDb;
  }

  static Database _database;

  Future<Database> get database async{
    if(_database==null){
      _database = await initDB();
    }
    return _database;
  }

  Future<Database> initDB() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "ingredients.db";
    print("ihtsi is  "+ path);

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb
    );
    this.backup("adsfas");
    return database;
  }

  _createDb(Database db,int version) async{
    await db.execute(
      "Create Table ingredients("
      "name TEXT PRIMARY KEY"
      ")"
      );
  }

  Future giveList() async{
    Database db = await this.database;
    var response = await db.rawQuery("SELECT * FROM ingredients ORDER BY name ASC");
    // print(response);
    return response;

  }

  insertIngredients(String value) async{
    value = value.toLowerCase();
    Database db = await this.database;
    Map<String,dynamic> m = new Map();

    m["name"]=value;
    int r = await searchIngredients(value);
    
    if(r==0)
      {
        try{

        db.insert('ingredients',m);
        this.giveList();

      }catch(e){
        print("error is " + e.toString());
      }}
    }

  searchIngredients(String value) async{
    Database db = await this.database;
    List<Map> m;
    m =await db.rawQuery("SELECT * FROM ingredients WHERE name='$value'");
    return m.length;
  }
  backup(String p) async{
    Directory directory = await getApplicationDocumentsDirectory();
    Directory directory1 = await getExternalStorageDirectory();
    String path = directory.path + "ingredients.db";
    final file = File(path);
    var response = await file.copy(directory1.path + "ingredients.db");
    print(response);
    print(directory1.path);
    // var content = await file.readAsBytes();
    // print(content);
  }
}