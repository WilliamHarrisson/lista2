import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../Models/cars.dart';

class CarListIten extends StatelessWidget {
  const CarListIten({Key? key,required this.carro, required this.onDelete}) : super(key: key);

final Carro carro;
final Function(Carro) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(actionExtentRatio: 0.25,
      actionPane:const SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          color: Colors.red,
          icon: Icons.delete,
          caption: 'Deletar',
          onTap: () {
            onDelete(carro);
          })
      ],child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4)
      ),
      
      padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Text(carro.dateTime.toString(),
          //style: TextStyle(fontSize: 12),
          //),

          Text(carro.title,
          style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400),
          )
      ],),
      ),
      ),)
    ;
  }
}