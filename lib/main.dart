import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ingridients/Database/product_database.dart';
import 'package:ingridients/models/data.dart';
import 'package:ingridients/screens/add_ingredients.dart';
import 'package:ingridients/screens/add_product.dart';
import 'package:ingridients/screens/delete.dart';
import 'package:path_provider/path_provider.dart';

import 'models/design.dart';

void main() => runApp(MaterialApp(
      title: "Ingridients",
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double height, width;
  String value;
  ProductDb _productDb;

  String n;
  GlobalKey<ScaffoldState> _globalKey;
  Data data;


  @override
  void initState() {
    data = new Data();
    _productDb = new ProductDb();
    n="";
    _globalKey = new GlobalKey();
    getProductList();
    super.initState();
  }

  

  getProductList() async {
    int r = await _productDb.giveProductList();
    if(r==1)
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          backgroundColor: color,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Best Food Forever"),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text("bestfoodfoerver2207@gmail.com"),
                accountName: Text("Best Food Forever",style: heading,),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: color,
                ),
              ),
              ListTile(
                title: Text("Add Ingredients",style: style,),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddIngredients())),
                leading: Icon(Icons.note_add,color: color,),
              ),
              ListTile(
                title: Text("Add Products",style: style,),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddProduct())),
                leading: Icon(Icons.note_add,color: color,),
              ),
              ListTile(
                title: Text("Delete",style: style,),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Delete())),
                leading: Icon(Icons.delete,color: color,),
              ),
              ListTile(
                title: Text("Update",style: style,),
                onTap: () async{
                  Directory directory = await getApplicationDocumentsDirectory();
                  Directory directory1 = await getExternalStorageDirectory();
                  String path = directory.path + "ingredients.db";
                  final file = File(path);
                  var response = await file.copy(directory1.path + "ingredients.db");
                  print(response);
                  print(directory1.path);
                },
                leading: Icon(Icons.update,color: color,),
              ),
            ],
          ),
        ),
        body: data.productList != null
            ? Column(children: <Widget>[
                Container(
                  height: height / 3,
                  width: width,
                  color: color.withOpacity(0.5),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            width: width,
                            child: DropdownButton(
                              isExpanded: true,
                                value: value,
                                onChanged: (val) {

                                  setState(() {
                                    value = val;
                                  });
                                },
                                items: data.productList.map((p) {
                                  return DropdownMenuItem<String>(
                                    child: Text(p.name),
                                    value: p.name,
                                  );
                                }).toList(),
                                ),
                          )
                              ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("    No. of Products "),
                            Container(
                              height: 80,
                              width: 80,
                              child: TextField(
                                decoration: InputDecoration(hintText: "No."),
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  n = val;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                          child: Text("Submit",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.black,
                          splashColor: Colors.amber,
                          onPressed: (){
                            if(n.length==0){
                              _globalKey.currentState.showSnackBar(SnackBar(content: Text("Enter Quantity")));  
                            }
                            else{
                              setState(() {});
                            }
                          })
                    ],
                  ),
                ),
                n.length!=0 && value!=null ?Expanded(
                    child: ListView.builder(
                  itemCount: data.nameProductList[value].ingredients.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              data.nameProductList[value].ingredients[index].name,
                              style: items,
                            ),
                            data.nameProductList[value].ingredients[index].quantity * int.parse(n)<1000?Text(
                              "${data.nameProductList[value].ingredients[index].quantity * int.parse(n)}  gm",
                              style: items,
                            ):Text(
                              "${data.nameProductList[value].ingredients[index].quantity * int.parse(n)/1000}  kg",
                              style: items,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )):Container(
                )
              ])
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
