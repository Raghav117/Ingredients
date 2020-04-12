import 'package:flutter/material.dart';
import 'package:ingridients/Database/ingredients_database.dart';
import 'package:ingridients/models/design.dart';

class AddIngredients extends StatefulWidget {
  @override
  _AddIngredientsState createState() => _AddIngredientsState();
}

class _AddIngredientsState extends State<AddIngredients> {
  String ingredient = "";
  IngredientDb _ingredientDb;
  List <Map<String,dynamic>> list;
  final _globalKey  = GlobalKey<ScaffoldState>();
  @override
  void initState() { 
    super.initState();
    _ingredientDb=IngredientDb();
    getList();
  }

  getList() async{
    list = await _ingredientDb.giveList();
    if(list!=null)
    {setState(() {
      
    });}
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Ingredients"),
        centerTitle: true,
        backgroundColor: color,
      ),
      key: _globalKey,
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
                      onChanged: (val){
                        ingredient=val;
                      },
  
                      decoration: InputDecoration(
                        hintText: "Add Ingredient"
                      ),
                    ),
                  ),
                        RaisedButton(
                          child: Text("Submit",style: TextStyle(color: Colors.white)),
                          color: Colors.black,
                          splashColor: Colors.amber,
                          onPressed: () async{
                            if(ingredient.length == 0){
                              _globalKey.currentState.showSnackBar(
                                SnackBar(content: Text("Value should not be empty"))
                              );
                            }else{
                              await _ingredientDb.insertIngredients(ingredient);
                              getList();
                            }
                          }
                          )
                ],
              ),
            ),

            Expanded(
              child: list!=null?ListView.builder(
                itemCount: list.length,
                
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12,left: 10),
                                      child: Card(
                          child: Text("${list[index]["name"].toString().toUpperCase()}",style: items,)
                    ),
                  );
                },
              ):Center(child: CircularProgressIndicator())
              )

          ]
        
    )
      
    );
  }
}