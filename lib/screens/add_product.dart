import 'package:flutter/material.dart';
// import 'package:ingridients/Database/product_database.dart';
import 'package:ingridients/models/data.dart';
import 'package:ingridients/screens/product.dart';
import 'package:ingridients/models/design.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String product;
  Data data;
  
  GlobalKey <ScaffoldState> _globalKey;

  @override
  void initState() { 
    product = "";
    data = Data();
    _globalKey = GlobalKey();
    super.initState();

  }

  //   getProductList() async {
  //   _productList = await _productDb.giveProductList();
  //   if (_productList != null) {
  //     setState(() {});
  //   }
  //   print(_productList);
  // }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: color,
        title: Text("Add Product"),
        centerTitle: true,
      ),
      body: Column(
          children: <Widget>[

            Container(
              height: height/4,
              width: width,
              color: color.withOpacity(0.5),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 100,
                    width: double.infinity,
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      onChanged: (val){
                        product=val;
                      },
                      decoration: InputDecoration(
                        hintText: "Add Product"
                      ),
                    ),
                  ),
                        RaisedButton(
                          child: Text("Add",style: TextStyle(color: Colors.white)),
                          color: Colors.black,
                          splashColor: Colors.amber,
                          onPressed: (){
                            product = product.toLowerCase();
                            product.length==0?_globalKey.currentState.showSnackBar(SnackBar(content: Text("Value Should not be Empty"),)):
                            data.nameProductList[product]!=null?_globalKey.currentState.showSnackBar(SnackBar(content: Text("Product already exist"),)):
                            Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context)=>Product(
                              product: product,
                              b: false,
                            ))
                          );}
                          
                          )
                ],
              ),
            ),

            // _productList.length!=null?
            Expanded(
              child: ListView.builder(
                itemCount: data.productList.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    
                    padding: EdgeInsets.only(bottom: 12,left: 10),
                                      child: ListTile(
                                        
                      title: Text(data.productList[index].name.toUpperCase(),style: items,),
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context)=>Product(
                            product: data.productList[index],
                            b: true,
                          ))
                        );
                      },
                    ),
                  );
                },
              )
              )
              // :Center(child: CircularProgressIndicator(),)
          ]
        
    )

    );
  }
}