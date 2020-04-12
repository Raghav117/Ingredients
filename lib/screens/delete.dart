import 'package:flutter/material.dart';
import 'package:ingridients/Database/product_database.dart';
import 'package:ingridients/models/data.dart';
import 'package:ingridients/models/design.dart';

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  Data _data;
  GlobalKey<ScaffoldState> _globalKey;

  String del;

  @override
  void initState() {
    _data = new Data();
    _globalKey = new GlobalKey();
    del = "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(title: Text("Delete Item"),
      centerTitle: true,
      backgroundColor: Colors.amber,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: height/4,
              child: TextField(
                textCapitalization: TextCapitalization.words,
                onChanged: (val){
                  del = val;
                },
                decoration: InputDecoration(
                  hintText: "Product For Delete"
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              elevation: 0.0,
              color: color,
              child: Icon(Icons.delete_forever,color: Colors.white,),
              onPressed: (){
                if(_data.nameProductList[del.toLowerCase()]==null){
                  _globalKey.currentState.showSnackBar(SnackBar(content: Text("Product does not exist")));
                }else{
                  ProductDb productDb =new ProductDb();
                  productDb.deleteProducts(_data.nameProductList[del.toLowerCase()].id);
                  _showDialog();
                }
              },
            )
          ],
        ),
            ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Deleted Sucessfully"),
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
}