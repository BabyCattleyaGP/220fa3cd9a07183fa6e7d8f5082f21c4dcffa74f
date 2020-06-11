import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/component/product_card.dart';
import 'package:flutter/material.dart';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/services/api_services.dart';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/model/product.dart';

class ProductListPage extends StatefulWidget {
  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {

  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasError) {
            return 
            Scaffold(
              body:
                Center(
                  child: Text(
                      "Something wrong with message: ${snapshot.error.toString()}"),
                )
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<ProductModel> products = snapshot.data;
            return _buildList(products);
          } else {
            return 
              Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                )
              );
          }
        },
      ),
    );
  }

  Widget _buildList(List<ProductModel> products) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = size.width / 2;
    
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleSpacing: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Kuliner",
            style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF000000),
            )
          ),
      ),
    
        body: products.isEmpty ? 
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:15.0),
                child: Text(
                  'Sorry,'
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:5.0, bottom:15.0),
                child: Text(
                  'We don`t have any product right now!'
                ),
              ),
              
            ],
          ),
        ) 
        :
        Container(
          child: 
            GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            children: List.generate(products.length, (index) {
              ProductModel product = products[index];
              return 
                ProductCard(
                  name:product.name,
                  price: product.price,
                  imageUrl: product.imageUrl,
                  brandName: product.brandName,
                  packageName: product.packageName,
                  rating: product.rating
                );                
            }),
          ),
        ),
    );
  }

}

