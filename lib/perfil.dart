import 'package:flutter/material.dart';
import 'main.dart';

class PerfilPetPage extends StatefulWidget {
final Pet pet;
const PerfilPetPage({super.key, required this.pet});

 State<PerfilPetPage> createState() => PerfilPetPageState();
}


class PerfilPetPageState extends State<PerfilPetPage> {
Pet get pet => widget.pet;
@override
Widget build(BuildContext context) {
return Card(
child: ListTile(
title: Text(pet.nome),
subtitle: Text('${pet.especie} - ${pet.idade} anos'),
),
);
}
}


