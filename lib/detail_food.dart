import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodexplorer/food.dart';

class DetailFood extends StatelessWidget{

  static const routeName = '/food_detail';
  final Food food;

  DetailFood({required this.food});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(food.name, style: TextStyle(color: Colors.black),),
        leading: IconButton(icon:Icon(Icons.arrow_back, color: Colors.black,),
          onPressed:() => Navigator.pop(context, false),
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(food.image),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.pink,
                        size: 18.0,
                        semanticLabel: 'Location',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(food.city, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 18.0,
                        semanticLabel: 'Rating',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(food.rating.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(food.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
