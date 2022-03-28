// class HomeModel
// {
//   bool? status;
//   HomeData? data;
//   HomeModel({this.status,this.data});
//
//   HomeModel.fromjson(Map<String, dynamic> json)
//   {
//     status = json['status'];
//     data = HomeData.fromjson(json['data']);
//   }
//
// }
//
// class HomeData{
// List<BannersModel> banners = [];
// List<ProductsModel> products = [];
//
//   HomeData.fromjson(Map<String,dynamic> json)
//   {
//     json['banners'].forEach((element){
//       banners!.add(element);
//     });
//     json['products'].forEach((element){
//       products!.add(element);
//     });
//   }
// }
// class BannersModel {
//   int? id;
//   String? image;
//
//   BannersModel.fromjson(Map<String,dynamic> json){
//     id= json['id'];
//     image= json['image'];
//   }
// }
//
// class ProductsModel{
//   int? id;
//   dynamic price;
//   dynamic old_price;
//   dynamic discount;
//   String? image;
//   String? name;
//   bool? in_favorites;
//   bool? in_cart;
//   ProductsModel.fromjson(Map<String,dynamic> json){
//     id = json['id'];
//     price = json['price'];
//     old_price = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     in_favorites = json['in_favorites'];
//     in_cart = json['in_cart'];
//   }
//
// }

class HomeModel {
  bool? status;
  Data? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<Banners>? banners = [];
  List<Products>? products =[];

  Data({this.banners, this.products,});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      //products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }


}

class Banners {
  int? id;
  String? image;

  Banners({this.id, this.image,});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

}

class Products {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Products(
      {
        this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description,
        this.images,
        this.inFavorites,
        this.inCart});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }


}