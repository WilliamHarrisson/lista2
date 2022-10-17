import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lista2/Repositories/car_repository.dart';

import '../Models/cars.dart';
import '../Widgets/car_list_item.dart';
class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {

final TextEditingController carrosController = TextEditingController();
final CarRepository carRepository = CarRepository();

 List<Carro> carros = [];
  Carro? deletedCarro;
  int? deletedCarroPos;

  String? errorText;

  @override
  void initState(){
    super.initState();
    carRepository.getCarList().then((value) {
      setState(() {
      carros = value;  
      });
      });
  }

 @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      body: Center(
      child:Padding(padding:
      const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Row(children: [
         Expanded(
          child: TextField(
          controller: carrosController,
          decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Adicione um carro',
          hintText: 'Nº - Equipe',
          errorText: errorText,
        ),
      ),
      ),
      const SizedBox(width: 8,),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(14),
        ),
        onPressed: () {
          String text = carrosController.text;

          if(text.isEmpty){
            setState(() {
            errorText = 'O carro não pode ser nulo';  
            });
            return;
          }
           
          setState(() { Carro newCarro = Carro(
            title: text,
            //dateTime: DateTime.now(),
          );
          carros.add(newCarro);
          errorText = null;
          });
          carrosController.clear();
          carRepository.saveCarList(carros);
        }, 
      child: const Icon(Icons.add,size: 40,),
      ),
      ]
    ),
      const SizedBox(height: 16,),
      Flexible(
        child: ListView(
          shrinkWrap: true,
          children: [
        for(Carro carro in carros)
          CarListIten(
            carro: carro,
            onDelete: onDelete),
    ]
    ),
    ),

    const SizedBox(height: 16,),
    Row(children:  [
      Expanded(child: Text('Você tem ${carros.length} carros registrados')),
      const SizedBox(height: 16),
        ElevatedButton(
        onPressed: showConfirmationDialog,
        child: const Text('Confirmar'),)
    ],)
    ],
    )
    ),
    ),
    ),
    );
  }
   void onDelete(Carro carro){
    deletedCarro = carro;
    deletedCarroPos = carros.indexOf(carro);
    setState(() {
      carros.remove(carro);
    });
    carRepository.saveCarList(carros);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Carro: ${carro.title} foi removido'),
      action: SnackBarAction(
        label: 'Desfazer', 
        onPressed:() {
          setState(() {
            carros.insert(deletedCarroPos!, deletedCarro!);
            }
            );
            carRepository.saveCarList(carros);
          }),
        duration: const Duration(seconds: 5)
        )
      );
  }
  

  void showConfirmationDialog(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Confirmação'),
      content: Text('Deseja enviar o registro dos ${carros.length} competidores ?'),
      actions:[
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text('Cancelar',style: TextStyle(color: Colors.red),)),
        TextButton(onPressed: (){
          print(carRepository.sharedPreferences.getString(carListKey));
          //Enviar os dados(em Json??) pra algum lugar
          Navigator.of(context).pop();
        }, child: const Text('Confirmar'))],
    ));
  }
}
  
 

 