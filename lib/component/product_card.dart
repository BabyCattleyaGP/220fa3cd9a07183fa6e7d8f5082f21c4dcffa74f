import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCard extends StatelessWidget{
  final String name;
  final int price;
  final String imageUrl;
  final String brandName;
  final String packageName;
  final double rating;

  ProductCard ({
    this.name,
    this.price,
    this.imageUrl,
    this.brandName,
    this.packageName,
    this.rating
  });

  final NumberFormat currency = 
  NumberFormat.currency(name: 'Rp', customPattern: '\u00a4 #,###', decimalDigits: 0);
  
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final cardWidth = 0.5 * (screenSize.width);
    final cardHeight =  0.5 * (screenSize.height  - kToolbarHeight);
    final imageWidth = cardWidth;
    final imageHeight = 0.35 * cardHeight;

    return 
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '$imageUrl',
                fit: BoxFit.cover,
                width: imageWidth,
                height: imageHeight,
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
                      this.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),

                    RatingBar(
                      initialRating: this.rating,
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
                  this.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),

                Flexible(
                  child: Container(
                    child: Text(
                      'by $name',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ),
                ),

                Container(
                  child:Text(
                    this.packageName
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
                  currency.format(price).toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),

                Container(
                  width: imageWidth,
                  child: RaisedButton(
                    onPressed: () {},
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
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}