import 'package:flutter/material.dart';
import 'package:foodexplorer/food.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Explorer',
      theme: ThemeData(),
      home: DetailScreen(),
    );
  }
}
 
class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: TextStyle(fontSize: 48),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Temukan makanan dan restoran sesuai cita rasa lokal',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<String>(
                future:
                    DefaultAssetBundle.of(context).loadString('assets/DATA.json'),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final List<Food> foods = parseFoods(snapshot.data);
                    return ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return _buildArticleItem(context, foods[index]);
                      },
                    );  
                  }
                  return CircularProgressIndicator();
                                                              
                },
              ),
            )
          ],
        )
      ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Food food) {
  return ListTile(
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(
      food.image,
      width: 100,
    ),
    title: Text(food.name),
    subtitle: Text(food.name),
  );
}