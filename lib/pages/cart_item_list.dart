import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';

class CartListPage extends StatefulWidget {
  @override
  CartListPageState createState() => CartListPageState();
}

class CartListPageState extends State<CartListPage> {
  List _elements = [
    {'name': 'Ayam Goreng Laos', 'group': 'Team A'},
    {'name': 'Kari Ayam', 'group': 'Team B'},
    {'name': 'Sop Ayam', 'group': 'Team A'},
    {'name': 'Upnormal', 'group': 'Team B'},
    {'name': 'Ayam Goreng Crisbar Special', 'group': 'Team C'},
  ];

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
          title: 
            Text(
              'Review Pesanan ',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        body: Container(
          margin: EdgeInsets.all(5.0), 
          child:
          Column(
            children: <Widget>[ 
              Container(
                margin: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Daftar Pesanan',
                          style: Theme.of(context).textTheme.bodyText1),
                    Text('Hapus Pesanan',
                          style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
              ),
              
              Expanded(
                child:
                GroupedListView<dynamic, String>(
                  groupBy: (element) => element['group'],
                  elements: _elements,
                  order: GroupedListOrder.DESC,
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
                      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: 
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: 
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 100.0,
                                    height: 70.0,
                                    decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.circular(6.0),
                                      color: Theme.of(context).accentColor,
                                      image: new DecorationImage(
                                        image: new NetworkImage(
                                            'https://via.placeholder.com/150'
                                          ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 170.0,
                                        child: 
                                          Text(element['name'], 
                                            style: Theme.of(context).textTheme.bodyText1
                                          )
                                      ),
                                      FaIcon( 
                                        FontAwesomeIcons.trash,
                                        color: Colors.grey,
                                        size: 14.0,
                                      )
                                    ],
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top:2.0, bottom:2.0),
                                    child:
                                      Text(element['name'], 
                                        style: TextStyle(fontSize: 10.0)
                                      )
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top:2.0, bottom:2.0),
                                    child: 
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container( child:
                                            Text('Rp 25.000', 
                                              style: Theme.of(context).textTheme.bodyText1
                                            ),
                                          ),

                                          Container(
                                            width: 120.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              // border: Border.all(
                                              //   color: Colors.blueAccent
                                              // )
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  width: 30.0,
                                                  child: RaisedButton(
                                                    color: Colors.white,
                                                    padding: EdgeInsets.all(2.0),
                                                    onPressed: () {},
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
                                                      '1',
                                                      style: Theme.of(context).textTheme.bodyText1,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 30.0,
                                                    child: RaisedButton(
                                                    color: Colors.white,
                                                    padding: EdgeInsets.all(2.0),
                                                    onPressed: () {},
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

                        // ListTile(
                        //   contentPadding:
                        //       EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        //   leading: Icon(Icons.account_circle),
                        //   title: Text(element['name'], style: Theme.of(context).textTheme.bodyText1,),
                        //   trailing: Icon(Icons.arrow_forward),
                        // ),
                      ),
                    );
                  },
                ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: 
        Visibility(
          child: 
          Padding(
            padding: EdgeInsets.all(2.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartListPage()),
              );
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
                            '4 Item | Rp. 25.000',
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
          //visible: quantityOfProductInCart.reduce((curr, element) => curr + element) > 0,
          visible: true,
          maintainSize: false, 
          maintainAnimation: false,
          maintainState: false,
        ),

    );
  }
}
