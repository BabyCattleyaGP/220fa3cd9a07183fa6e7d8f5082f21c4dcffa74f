import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/component/product_card.dart';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/services/api_services.dart';
import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductListPage extends StatefulWidget {
  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> with TickerProviderStateMixin{

  AnimationController _animationController;
  CalendarController _calendarController;
  ApiService apiService;

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
    
    return Scaffold(
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
          ],
        ),
    );
  }
}
