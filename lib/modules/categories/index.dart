import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../web_view/index.dart';
import '../home/index.dart';
class CategoriesPage extends StatefulWidget{
  _categoriesPageState createState()=>_categoriesPageState();
}
class _categoriesPageState extends State<CategoriesPage>{
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: Text('Shopping'),
          centerTitle: true,
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(26),
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: <Widget>[
            cards('Shopping','Shopping',Icon(Icons.shopping_basket)),
            cards('Recharges','Recharges',Icon(Icons.account_balance_wallet)),
            cards('Flights and Tickets','Flights',Icon(Icons.flight)),
            cards('Train','Train',Icon(Icons.train))

          ],
        )
    );
  }

  Widget cards(image,title,icon){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()));
      },
      child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(width: 1.0,color: Colors.grey.shade300)),
          height: 0.2,
          child: Column(
              children: <Widget>[
                Expanded(
                    child: icon),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                )
              ])),
    );
  }
}