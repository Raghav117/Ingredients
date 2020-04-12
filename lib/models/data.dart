
class Ingredients{
  String name;
  double quantity;

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
  Map<String,Products> nameProductList = new Map();
  List<Products> productList;

  static final Data _data = Data._internal();

  Data._internal();

  factory Data() {
    return _data;
  }

  giveNameProductList() async{
      nameProductList.clear();
      for(var p in productList){
        nameProductList[p.name]=p;
      }
  }
}