import 'dart:io';
import 'package:ingridients/models/data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'dart:async';
import 'dart:typed_data';

class ProductDb {
  static final ProductDb _product = ProductDb._internal();
  ProductDb._internal();

  factory ProductDb() {
    return _product;
  }

  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Directory directory1 = await getTemporaryDirectory();
    print(directory1.path);
    String path = directory.path + "priducts.db";
    print("this is [atna;" + path);
    // this.backup("dfasd");
    Database database = await databaseFactoryIo.openDatabase(path);
    return database;
  }

  static final _instance = intMapStoreFactory.store("Products");



  Future giveProductList() async {
    Database db = await this.database;

    final finder = new Finder(sortOrders: [SortOrder("name")]);

    final response = await _instance.find(db, finder: finder);
    List<Products> l = List<Products>();
    for (var r in response) {
      Products p = Products.fromMap(r.value, r.key);
      l.add(p);
    }
    for(var a in l){
      print(a.name);
    }
    Data().productList = l;
    Data().giveNameProductList();
    print(Data().productList.length);
    return 1;
  }

  insertProducts(Map m) async {
    Database db = await this.database;
    
      try {
        await _instance.add(db, m);
        this.giveProductList();

      } catch (e) {
        print("error is " + e.toString());
      }
      
    
  }

  searchProducts(String value) async {
    Database db = await this.database;
    var count = await _instance.count(db, filter: Filter.equals("name", value));
    return count;
  }

  deleteProducts(int id) async {
    Database db = await this.database;

    int r = await _instance.delete(db, finder: Finder(filter: Filter.byKey(id)));
    if(r>0)
      this.giveProductList();

  }

  updateProducts(Map m, int id) async {
    Database db = await this.database;
    int r = await _instance.update(db, m, finder: Finder(filter: Filter.byKey(id)));
    print("r is " + r.toString());
    if(r>0)
      this.giveProductList();
  }

  backup(String p) async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "priducts.db";
    final file = File(path);

    String content = await file.readAsString();
    print(content);
  }

  writeToFile(ByteData data,String path){
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
      buffer.asUint8List(data.offsetInBytes,data.lengthInBytes)
    );
  }
}
