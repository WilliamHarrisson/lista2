import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:lista2/Models/cars.dart';

const carListKey = 'car_list';

class CarRepository{
 
 late SharedPreferences sharedPreferences;

 Future<List<Carro>> getCarList() async {
  sharedPreferences = await SharedPreferences.getInstance();
  final String jsonString = sharedPreferences.getString(carListKey) ?? '[]';
  final List jsonDecoded = jsonDecode(jsonString) as List;
  return jsonDecoded.map((e) => Carro.fromJson(e)).toList();
 }
 
 void saveCarList(List<Carro> carros){
    final String jsonString = json.encode(carros);
    sharedPreferences.setString(carListKey, jsonString);
 }
}