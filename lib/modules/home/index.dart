import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../web_view/index.dart';
class HomePage extends StatefulWidget{
  final String category;
  HomePage({this.category});
  _homePageState createState()=>_homePageState(category: this.category);
}
class _homePageState extends State<HomePage>{
  final String category;
  _homePageState({this.category});
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text('Shopping'),
        centerTitle: true,
        automaticallyImplyLeading: false
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(26),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        children: <Widget>[
         cards('amazon.png','Amazon','https://www.amazon.in'),
         cards('flipkart.png','Flipkart','https://www.flipkart.com'),
         cards('myntra.png','Myntra','https://www.myntra.com'),
         cards('ajio.jpg','Ajio','https://www.ajio.com'),
         cards('jabong.jpg','Jabong','https://www.jabong.com'),
         cards('limeroad.png','LimeRoad','https://www.limeroad.com'),
        ],
      )
    );
  }

  Widget cards(image,title,String url){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyWebView(
              title: title,
              selectedUrl: url,
            )));
      },
      child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(bottom: 20.0),
          height: 0.2,
          child: Row(
              children: <Widget>[
          Expanded(child: Container(
              decoration: BoxDecoration(
              //image: DecorationImage(image: CachedNetworkImageProvider(image), fit: BoxFit.contain),
              image: DecorationImage(image: AssetImage('assets/${image}'),fit: BoxFit.contain),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(width: 1.0,color: Colors.grey.shade300)
      ),
      ))
      ])),
    );
  }
}