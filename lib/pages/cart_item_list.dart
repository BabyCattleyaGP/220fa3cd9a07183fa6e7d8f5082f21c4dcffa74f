import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/model/cart.dart';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/model/product.dart';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/services/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

class CartListPage extends StatefulWidget {
  @override
  CartListPageState createState() => CartListPageState();
}

class CartListPageState extends State<CartListPage> {

  SharedPreferencesServices sharedPref = SharedPreferencesServices();
  List quantityOfProductInCart = [];
  List<ProductModel> productInCart = [];
  List _elements;

  int totalPrice = 0;
  int totalItem = 0;

  void loadSharedPrefs() async {
    String data = await sharedPref.read("cart");
    List<ProductModel> temp = [];
    if(data != null){
      CartModel cart = cartFromJson(data);
      if(cart.totalItem != 0){
        cart.products.forEach(
          (element) => {
              temp.add(element),
            }
        );
        setState(() {
          totalItem = cart.totalItem;
          totalPrice = cart.totalPrice;
          productInCart = temp;
          _elements = cart.products;
        });
      } else{
        setState(() {
          totalItem = 0;
          totalPrice = 0; 
          productInCart = temp;
          _elements = cart.products;     
        });
      }
    }
    else{
      setState(() {
        totalItem = 0;
        totalPrice = 0;
        productInCart = temp;
        _elements = temp;     
      });
    }
  }

  Future<bool> _whenDeleteAll() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
                'Apakah Anda yakin?', 
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1
                ),
        content: new Text(
          'Semua pesanan Anda akan terhapus', 
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2
          ),
        actions: 
        <Widget>[
          new FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Theme.of(context).accentColor)
            ),
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 5.0),
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              'KEMBALI',
              style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0
                  )
              ),
          ),
          new FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Color(0xFFFDBF2E))
            ),
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 5.0),
            onPressed:() {
              sharedPref.remove("cart");
              setState((){
                totalItem = 0;
                totalPrice = 0;
              });
              loadSharedPrefs(); 
              Navigator.of(context).pop(false);            
            },
            child: new Text(
              'YA',
              style: TextStyle(
                    color: Color(0xFFFDBF2E),
                    fontSize: 12.0
                  )
              ),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currency = 
  NumberFormat.currency(name: 'Rp', customPattern: '\u00a4 #,###', decimalDigits: 0);
    final Size screenSize = MediaQuery.of(context).size;
    final cardWidth = 0.95 * (screenSize.width);
    final cardHeight =  0.2 * (screenSize.height  - kToolbarHeight);
    final imageWidth = 0.35 * cardWidth;
    final imageHeight = 0.8 * cardHeight;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleSpacing: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: 
            Text(
              'Review Pesanan ',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        body: 
        totalItem != 0 ? 
          Container(
            margin: EdgeInsets.only(left:5.0, bottom: 2.0, right: 10.0), 
            child:
            Column(
              children: <Widget>[ 
                Container(
                  margin: EdgeInsets.only(left:10.0, bottom: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Daftar Pesanan',
                        style: Theme.of(context).textTheme.bodyText1),
                      Container(
                        margin: EdgeInsets.only(bottom: 2.0),
                        child: RaisedButton(  
                          color: Colors.white.withOpacity(0.1),
                          elevation:0.0,
                          onPressed: () {
                            _whenDeleteAll();
                          },
                          child:  Text('Hapus Pesanan',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ),

                    ],
                  ),
                ),
                
                Expanded(
                  child:
                  GroupedListView<dynamic, String>(
                    groupBy: (element) => (DateFormat.yMMMMd("en_US").format(element.orderDate)).toString(),
                    elements: _elements,
                    order: GroupedListOrder.ASC,
                    useStickyGroupSeparators: false,
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                    ),
                    itemBuilder: (c, element) {
                      return Card(
                        margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                        child: 
                        Container(
                          padding: EdgeInsets.all(5.0),
                          width: cardWidth,
                          height: cardHeight,
                          child: 
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: imageWidth,
                                      height: imageHeight,
                                      decoration: new BoxDecoration(
                                        borderRadius: new BorderRadius.circular(6.0),
                                        color: Theme.of(context).accentColor,
                                        image: new DecorationImage(
                                          image: new NetworkImage(
                                              '${element.imageUrl.toString()}'
                                            ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 4.0, bottom: 2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 0.40 * cardWidth,
                                          child: 
                                            Text(element.name, 
                                              style: Theme.of(context).textTheme.bodyText1
                                            )
                                        ),
                                        Container(
                                          child: IconButton(
                                            icon: FaIcon( 
                                              FontAwesomeIcons.trash,
                                              color: Colors.grey,
                                              size: 14.0,
                                            ), 
                                            onPressed: () { 
                                              var toRemove = [];
                                              productInCart.forEach(
                                                (item) => {
                                                  if(item.id == element.id){
                                                    toRemove.add(element),
                                                  }
                                                }
                                              );                                       
                                              productInCart.removeWhere((item) => toRemove.contains(item));

                                              if(productInCart != []){
                                                int temptotalItem = 0;
                                                int temptotalPrice = 0;

                                                for(int i=0; i<productInCart.length; i++){
                                                  temptotalItem += productInCart[i].quantity;
                                                }
                                                
                                                for (var i = 0; i < productInCart.length; i++) {
                                                  temptotalPrice = temptotalPrice + (productInCart[i].price * productInCart[i].quantity);
                                                }

                                                setState((){
                                                  totalItem = temptotalItem;
                                                  totalPrice = temptotalPrice;
                                                });

                                                productInCart.sort((a, b) => a.id.compareTo(b.id));
                                                CartModel userCart = CartModel(totalPrice: totalPrice, totalItem: totalItem, products: productInCart);
                                                sharedPref.save("cart", cartToJson(userCart)); 
                                                loadSharedPrefs();
                                              }
                                              else{
                                                sharedPref.remove("cart");
                                                setState((){
                                                  totalItem = 0;
                                                  totalPrice = 0;
                                                });
                                              } 
                                            }
                                          ),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(bottom:2.0),
                                      height: 0.15*cardHeight,
                                      child:
                                        Text(element.brandName, 
                                          style: TextStyle(fontSize: 10.0)
                                        )
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(top:2.0, bottom:2.0),
                                      height: 0.2*cardHeight,
                                      child: 
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container( 
                                              width: 0.2*cardWidth,
                                              child:
                                              Text(currency.format(element.price).toString(), 
                                                style: Theme.of(context).textTheme.bodyText1
                                              ),
                                            ),

                                            Container(
                                              width: 0.3*cardWidth,
                                              margin: EdgeInsets.only(left:5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    width: 30.0,
                                                    child: RaisedButton(
                                                      color: Colors.white,
                                                      padding: EdgeInsets.all(2.0),
                                                      disabledColor: Colors.grey[50],
                                                      disabledElevation: 1.0,
                                                      onPressed: element.quantity <= 1 ? null : 
                                                      () {
                                                        int temptotalPrice = 0;
                                                        int temptotalItem = 0;
                                                        element.quantity--;

                                                        for(int i=0; i<productInCart.length; i++){
                                                          temptotalItem += productInCart[i].quantity;
                                                        }
                                                        
                                                        for (var i = 0; i < productInCart.length; i++) {
                                                          temptotalPrice = temptotalPrice + (productInCart[i].price * productInCart[i].quantity);
                                                        }

                                                        setState((){
                                                          totalItem = temptotalItem;
                                                          totalPrice = temptotalPrice;
                                                        });

                                                        var toRemove = [];
                                            
                                                        productInCart.forEach(
                                                          (element) => {
                                                            if(element.quantity == 0){
                                                              toRemove.add(element),
                                                            }
                                                          }
                                                        );

                                                        productInCart.removeWhere((item) => toRemove.contains(item));
                                                        if(productInCart != []){
                                                          productInCart.sort((a, b) => a.id.compareTo(b.id));
                                                          CartModel userCart = CartModel(totalPrice: totalPrice, totalItem: totalItem, products: productInCart);
                                                          sharedPref.save("cart", cartToJson(userCart)); 
                                                        }
                                                        else{
                                                          sharedPref.remove("cart");
                                                        }
                                                      },
                                                      child: Text(
                                                        '-',
                                                        style: Theme.of(context).textTheme.bodyText1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 30.0,
                                                    color: Colors.white,
                                                    padding: EdgeInsets.all(2.0),
                                                    child: 
                                                    Center(
                                                      child: Text(
                                                        '${element.quantity}',
                                                        style: Theme.of(context).textTheme.bodyText1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 30.0,
                                                      child: RaisedButton(
                                                      color: Colors.white,
                                                      padding: EdgeInsets.all(2.0),
                                                      onPressed: () {
                                                        int temptotalPrice = 0;
                                                        int temptotalItem = 0;
                                                        element.quantity++;

                                                        for(int i=0; i<productInCart.length; i++){
                                                          temptotalItem += productInCart[i].quantity;
                                                        }
                                                        
                                                        for (var i = 0; i < productInCart.length; i++) {
                                                          temptotalPrice = temptotalPrice + (productInCart[i].price * productInCart[i].quantity);
                                                        }

                                                        productInCart.sort((a, b) => a.id.compareTo(b.id));

                                                        setState((){
                                                          totalItem = temptotalItem;
                                                          totalPrice = temptotalPrice;
                                                          _elements = productInCart;
                                                        });

                                                        CartModel userCart = CartModel(totalPrice: totalPrice, totalItem: totalItem, products: productInCart);
                                                        sharedPref.save("cart", cartToJson(userCart)); 
                                                      },
                                                      child: Text(
                                                        '+',
                                                        style: Theme.of(context).textTheme.bodyText1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )


                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ),

                            ],
                          )

                        ),
                      );
                    },
                  ),
              ),
            ],
          ),
        )
        :
        Container(
          child:
          Center(
            child: 
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/undraw_empty_cart.png',
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
                Container(
                  margin: EdgeInsets.all(7.0),
                  child: Text(
                    'Keranjangmu masih kosong nih',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),

                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top:150.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    padding: EdgeInsets.only(bottom:20.0, top:20.0, left:100.0, right:100.0),
                    child: const Text('Pesan Sekarang', style: TextStyle(fontSize: 14.0)),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    elevation: 5,
                  )
                ),
              ],
            )
          )
        ),

      bottomNavigationBar: 
        Visibility(
          child: 
          Padding(
            padding: EdgeInsets.all(2.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: 
                Container( 
                  height: 60.0,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$totalItem Item | ${currency.format(totalPrice).toString()}',
                            style: TextStyle(
                              fontSize: 12.0
                            ),
                          ),
                          Text(
                            'Termasuk ongkos kirim',
                            style: TextStyle(
                              fontSize: 12.0
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right:2.0),
                            child: Text(
                              'CHECKOUT',
                              style: TextStyle(
                                fontSize: 12.0
                              ),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.white,
                            size: 12.0,
                          )
                        ],
                      )
                    ],
                  ),
                ),
            ),
          ),
          visible: totalItem != 0 ? true : false,
          maintainSize: false, 
          maintainAnimation: false,
          maintainState: false,
        ),

    );
  }
}
