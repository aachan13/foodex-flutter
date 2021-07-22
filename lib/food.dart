import 'dart:convert';

class Food{

  late String id;
  late String name;
  late String description;
  late String city;
  late String image;
  late String shortDesc;
  late num rating;
 
  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.image,
    required this.shortDesc,
    required this.rating,
  });

  Food.fromJson(Map<String, dynamic> food) {
    id = food['id'];
    name = food['name'];
    description = food['description'];
    city = food['city'];
    image = food['pictureId'];
    shortDesc = food['description'].substring(0, 150) + '...';
    rating = food['rating'];
  }
  
}

List<Food> parseFoods(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json);
  return parsed.map((json) => Food.fromJson(json)).toList();
}
