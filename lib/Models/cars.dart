class Carro{

  Carro.fromJson(Map<String, dynamic> json)
  : title = json['title'];
  //dateTime = DateTime.parse(json['dateTime']);
  

  Carro({required this.title}); //required this.dateTime});
  String title;
  //DateTime dateTime;
  
Map<String, dynamic> toJson (){
    return{
      'title': title,
      //dateTime : dateTime.toIso8601String()
    };
  }
}
