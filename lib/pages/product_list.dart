import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/component/product_card.dart';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/services/api_services.dart';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductListPage extends StatefulWidget {
  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> with TickerProviderStateMixin{

  AnimationController _animationController;
  CalendarController _calendarController;
  ApiService apiService;
  List quantityOfProductInCart = [];

  int totalPrice = 0;
  int totalItem = 0;
  int temptotalPrice = 0;
    
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    apiService = ApiService();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  DateTime _selected = DateTime.now();

  void _onDaySelected(DateTime day, List products) {
    setState(() {
      _selected = day;
    });
    // print('CALLBACK: _onDaySelected');
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    // print('CALLBACK: _onCalendarCreated');
  }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  // void _decrementCounter() {
  //   setState(() {
  //     _counter--;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleSpacing: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[ 
                  Text(
                    'Alamat Pengantaran  ',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  FaIcon( 
                    FontAwesomeIcons.chevronDown,
                    color: Colors.orange,
                    size: 12.0,
                  )
                ]
              ),
              Text(
                'Jakarta',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 5.0),
          _buildTableCalendar(),
          const SizedBox(height: 5.0),
          Expanded(child: _buildProductList()),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      headerVisible: false,
      calendarController: _calendarController,
      startDay: DateTime.now(),
      endDay: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 56),
      enabledDayPredicate: (date) {
        return (date.weekday != DateTime.sunday) && (date.weekday != DateTime.saturday);
      },
      initialCalendarFormat: CalendarFormat.week,
      initialSelectedDay: DateTime.now(),
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(fontWeight: FontWeight.bold).copyWith(color: Color(0xFFb9bdbf)),
        weekdayStyle: TextStyle(fontWeight: FontWeight.bold).copyWith(color: Colors.black),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange, Colors.white]
              ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                ),
              ),
              width: 100,
              height: 100,
              child: Center(
                  child:Text(
                  '${date.day}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ).copyWith(fontSize: 12.0),
                ),
              )
            ),
          );
        },

        todayDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange, Colors.white]
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              ),
            ),
            width: 100,
            height: 100,
            child: Center( 
              child:Text(
              '${date.day}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ).copyWith(fontSize: 12.0),
            )),
          );
        },

        dayBuilder: (context, date, _){
          return Container(
            color: Color(0xFFE4E4E4),
            child: Center( 
              child: Text(
              '${date.day}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ).copyWith(fontSize: 12.0),
            )),
          );
        },

        unavailableDayBuilder: (context, date, _){
          return Container(
            color: Color(0xFFE4E4E4),
            child: Center(
              child: Text(
              '${date.day}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFb9bdbf),
              ).copyWith(fontSize: 12.0),
            )),
          );
        }
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildProductList() {
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

    final Size screenSize = MediaQuery.of(context).size;
    final cardWidth = 0.5 * (screenSize.width);
    final cardHeight =  0.5 * (screenSize.height  - kToolbarHeight);
    final imageWidth = cardWidth;
    final imageHeight = 0.35 * cardHeight;

    final NumberFormat currency = 
  NumberFormat.currency(name: 'Rp', customPattern: '\u00a4 #,###', decimalDigits: 0);

    for (var i=0; i<products.length; i++){
      quantityOfProductInCart.add(0);
    }

    return Scaffold(
        body: (products.isEmpty 
                || 
              ((_selected.weekday == DateTime.sunday) || (_selected.weekday == DateTime.saturday))
            ) ? 
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
                  'We don`t have any product for today!'
                ),
              ),
              
            ],
          ),
        ) 
        :
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                (DateFormat.yMMMMd("en_US").format(_selected)).toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Expanded(
              child: 
                GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                children: List.generate(products.length, (index) {
                  ProductModel product = products[index];
                  return 
                    // ProductCard(
                    //   name:product.name,
                    //   price: product.price,
                    //   imageUrl: product.imageUrl,
                    //   brandName: product.brandName,
                    //   packageName: product.packageName,
                    //   rating: product.rating
                    // );
                  Container(
                    padding: EdgeInsets.all(2.0),
                    margin: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: 
                          Container(
                            width: imageWidth,
                            height: imageHeight,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(6.0),
                              color: Theme.of(context).accentColor,
                              image: new DecorationImage(
                                image: new NetworkImage(
                                    '${product.imageUrl.toString()}'
                                  ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          height: 0.3 * cardHeight,
                          width: imageWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    product.rating.toStringAsFixed(1),
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),

                                  RatingBar(
                                    initialRating: product.rating,
                                    ignoreGestures: true,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber
                                    ),
                                    itemSize: 20.0,
                                    onRatingUpdate: (rating) {},
                                  ),               
                                ],
                              ),

                              Text(
                                product.name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),

                              Flexible(
                                child: Container(
                                  child: Text(
                                    'by ${product.brandName}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyText2,
                                  )
                                ),
                              ),

                              Container(
                                child:Text(
                                  product.packageName
                                )
                              ), 

                            ],
                          )
                        ),

                        Container(
                          height: 0.27 * cardHeight,
                          width: imageWidth,
                          padding: EdgeInsets.all(0.0),
                          margin:  EdgeInsets.all(0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                currency.format(product.price).toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),

                              Container(
                                width: imageWidth,
                                child: quantityOfProductInCart[index] == 0 ?
                                  RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        quantityOfProductInCart[index]++;
                                        totalItem = quantityOfProductInCart.reduce((curr, element) => curr + element);
                                      });
                                      temptotalPrice = 0;
                                      for (var i = 0; i < products.length; i++) {
                                       temptotalPrice = temptotalPrice + (products[i].price * quantityOfProductInCart[i]);
                                      }
                                      setState(() {
                                        totalPrice = temptotalPrice;
                                      });
                                    },
                                    color: Color(0xFFFFFFFF),
                                    padding: EdgeInsets.all(2.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(8.0),
                                      side: BorderSide(color: Theme.of(context).accentColor)
                                    ),
                                    child: 
                                      Text('Tambah ke keranjang',
                                        style: 
                                          TextStyle(
                                            fontSize: 12.0,
                                            color: Theme.of(context).accentColor,
                                          )
                                      ),
                                    )
                                  : 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: 0.3 * cardWidth,
                                        margin: EdgeInsets.only(right: 2.0),
                                        child: 
                                        RaisedButton(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(2.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(8.0),
                                            side: BorderSide(color: Colors.grey[100])
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              quantityOfProductInCart[index]--;
                                              totalItem = quantityOfProductInCart.reduce((curr, element) => curr + element);
                                            });
                                            for (var i = 0; i < products.length; i++) {
                                              temptotalPrice = temptotalPrice + (products[i].price * quantityOfProductInCart[i]);
                                            }
                                            setState(() {
                                              totalPrice = temptotalPrice;
                                            });
                                          },
                                          child: 
                                          Text(
                                            '-',
                                            style: 
                                            TextStyle(
                                              color: Theme.of(context).accentColor,
                                              fontSize: 16.0
                                            ),
                                          ),
                                        ),
                                      ),
                                      
                                      Container(
                                        width: 0.3 * cardWidth,
                                        margin: EdgeInsets.only(right: 2.0),
                                        child: 
                                        RaisedButton(
                                        color: Colors.white,
                                          padding: EdgeInsets.all(2.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(8.0),
                                            side: BorderSide(color: Colors.grey[100])
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            '${quantityOfProductInCart[index]}',
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                        ),
                                      ),

                                      
                                      Container(
                                        width: 0.3 * cardWidth,
                                        child: 
                                        RaisedButton(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(2.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(8.0),
                                            side: BorderSide(color: Colors.grey[100])
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              quantityOfProductInCart[index]++;
                                              totalItem = quantityOfProductInCart.reduce((curr, element) => curr + element);
                                            });
                                            for (var i = 0; i < products.length; i++) {
                                              temptotalPrice = temptotalPrice + (products[i].price * quantityOfProductInCart[i]);
                                            }
                                            setState(() {
                                              totalPrice = temptotalPrice;
                                            });
                                          },
                                          child: Text(
                                            '+',
                                            style: TextStyle(
                                              color: Theme.of(context).accentColor,
                                              fontSize: 16.0
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );

                }),
              ),
            ),
          ],
        ),

        bottomNavigationBar: 
          Visibility(
            child: 
            Padding(
              padding: EdgeInsets.all(2.0),
              child: RaisedButton(
                onPressed: () {},
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
                        FaIcon(
                          FontAwesomeIcons.shoppingCart,
                          color: Colors.white
                        )
                      ],
                    ),
                  ),
              ),
            ),
            visible: quantityOfProductInCart.reduce((curr, element) => curr + element) > 0,
            maintainSize: false, 
            maintainAnimation: false,
            maintainState: false,
          ),
    );
  }
}
