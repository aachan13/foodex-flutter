import 'dart:convert';

class Food{

  late String id;
  late String name;
  late String description;
  late String city;
  late String image;
  late num rating;
 
  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.image,
    required this.rating
  });

  Food.fromJson(Map<String, dynamic> food) {
    id = food['id'];
    name = food['name'];
    description = food['description'];
    city = food['city'];
    image = food['pictureId'];
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

