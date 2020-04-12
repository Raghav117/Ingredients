import 'package:flutter/material.dart';
import 'package:ingridients/Database/ingredients_database.dart';
import 'package:ingridients/Database/product_database.dart';
import 'package:ingridients/models/data.dart';
import 'package:ingridients/models/design.dart';

class Product extends StatefulWidget {
  final product;
  final bool b;

  const Product({Key key, this.product, this.b}) : super(key: key);
  @override
  _ProductState createState() => _ProductState(
    this.product,
    this.b
  );
}

class _ProductState extends State<Product> {
  List list;
  IngredientDb _ingredientDb;
  List<double> text;
  final  product;
  final bool b;
  GlobalKey<ScaffoldState> _globalKey;

  _ProductState(this.product, this.b);

  @override
  void initState() {
    _ingredientDb = IngredientDb();
    text = new List();
    getList();
    _globalKey = new GlobalKey();
    super.initState();
  }

  getList() async {
    list = await _ingredientDb.giveList();
    if (list != null) {
      for (int i = 0; i < list.length; ++i) {
        text.add(0);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Product Details"),
        centerTitle: true,
        backgroundColor: color,
      ),
      body: list != null
          ? Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Text(b==true?product.name.toString().toUpperCase():product.toString().toUpperCase(),style: items,),
                  )
                ),
                Divider(
                  height: 10,
                  thickness: 5.0,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                "${list[index]["name"].toString().toUpperCase()}",
                                style: items,
                              )),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 60,
                                      height: 30,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                          if (val.length == 0)
                                            text[index] = 0.0;
                                          else
                                            text[index] = double.parse(val);
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: Text("   gm"),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                        );
                      }),
                ),
                b==false?RaisedButton(
                  onPressed: () {
                    
                      var object = makeObject(list, text);
                      Map<String,dynamic> m = new Map<String,dynamic>();
                      List m1 = new List();
                      for (var v in object) m1.add(v.toJson());
                      m['ingredients'] = m1;
                      m['name'] = product.toString().toLowerCase();


                      ProductDb p = new ProductDb();
                      p.insertProducts(m);
                      _showDialog();
                    
                  },
                  child: Text("Submit", style: TextStyle(color: Colors.white)),
                  color: color,
                  splashColor: Colors.amber,
                ):
                RaisedButton(
                  child: Text("Update", style: TextStyle(color: Colors.white)),
                  color: color,
                  splashColor: Colors.amber,

                  onPressed: (){
                    
                      var object = makeObject(list, text);
                      Map<String,dynamic> m = new Map<String,dynamic>();
                      List m1 = new List();
                      for (var v in object) m1.add(v.toJson());
                      m['ingredients'] = m1;
                      print(product.name);
                      m['name'] = (product.name).toString().toLowerCase();

                      ProductDb p = new ProductDb();
                      p.updateProducts(m,product.id);
                      _showDialog();


                  }
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: b==false?new Text("Insert Sucessfully"):new Text("Update Sucessfully"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  makeObject(List l, List q) {
    List<Ingredients> a = new List();
    for (int v = 0; v < l.length; ++v) {
      // print(q[v]);
      if(q[v]!=0)
      {
        Ingredients i = new Ingredients(q[v], l[v]["name"]);
        a.add(i);
        }
    }
    return a;
  }
}
