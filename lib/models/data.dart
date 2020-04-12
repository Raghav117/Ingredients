
class Ingredients{
  double quantity;
  String name;

  Ingredients(this.quantity, this.name);

  Map<String, dynamic> toJson() => <String, dynamic>{'quantity': quantity, 'name': name};
  Ingredients.fromJson(Map m){
    this.quantity = m["quantity"];
    this.name = m["name"];
  }

}

class Products{
  int id;
  List<Ingredients> ingredients;
  String name;
fit 
  Products(this.ingredients, this.name);

  Products.fromMap(Map m,int id){
    
    List<Ingredients> l = new List<Ingredients>();
    
    for (var i in m["ingredients"]) {
      Ingredients p = Ingredients.fromJson(i);
      l.add(p);
    }
    this.name = m["name"];
    this.id = id;
    this.ingredients = l;
  }
}


class Data{

  static final Data _data = Data._internal();
  Data._internal();

  factory Data() {
    return _data;
  }

  Map<String,Products> nameProductList = new Map();
  List<Products> productList;

  giveNameProductList() async{
      nameProductList.clear();
      for(var p in productList){
        nameProductList[p.name]=p;
      }
  }


}