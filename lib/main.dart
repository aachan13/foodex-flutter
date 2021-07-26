import 'package:flutter/material.dart';
import 'package:foodexplorer/detail_food.dart';
import 'package:foodexplorer/food.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Explorer',
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: Home(),
      initialRoute: _HomeState.routeName,
      routes: {
        _HomeState.routeName: (context) => Home(),
        DetailFood.routeName: (context) => DetailFood(
              food: ModalRoute.of(context)?.settings.arguments as Food,
            ),
      },
    );
  }
}

class Home extends StatefulWidget {
 
    @override
    _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const routeName = '/food_list';
  int favoriteCount = 0;

  void increaseFavCount() {
    setState(() {
      favoriteCount++;
      final snackBar = SnackBar(
        content: Text('Fav btn clicked $favoriteCount times'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: increaseFavCount,
        child: const Icon(Icons.favorite_border),
        backgroundColor: Color.fromRGBO(234, 91, 73, 1),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(24, 64, 24, 32),
              child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Food Explorer',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Temukan makanan dan restoran sesuai cita rasa lokal',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Chip(
                    backgroundColor: Color.fromRGBO(234, 91, 73, 1),
                    label: Text('$favoriteCount Difavorit.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: FutureBuilder<String>(
                future:
                    DefaultAssetBundle.of(context).loadString('assets/DATA.json'),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final List<Food> foods = parseFoods(snapshot.data);
                    return ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return _buildFoodItem(context, foods[index]);
                      },
                    );  
                  }
                  return CircularProgressIndicator();
                                                              
                },
              ),
              )
            )
          ],
        )
      ),
    );
  }
}

Widget _buildFoodItem(BuildContext context, Food food) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(context, DetailFood.routeName,
            arguments: food);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Stack(
                      alignment: const Alignment(-1, 0.6),
                      children: [
                        Container(
                          child: Image.network(
                            food.image,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Text(
                              food.name,
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ),
                      ],
                    )
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
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
                )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(food.shortDesc, style: TextStyle(height: 1.5),),
              ),
            ],
          )
        ),
  );
}