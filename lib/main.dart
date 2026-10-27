import 'package:flutter/material.dart';
import 'package:flutter_application_1/perfil.dart';

void main() => runApp(const MaterialApp(home: FormularioExemplo()));

class FormularioExemplo extends StatefulWidget {
  const FormularioExemplo({super.key});

  @override
  State<FormularioExemplo> createState() => _FormularioExemploState();
}
class Pet {
final String nome;
final String especie;
final int idade;
final bool eCastrado;
Pet({
required this.nome,
required this.especie,
required this.idade,
required this.eCastrado,
});
}

class _FormularioExemploState extends State<FormularioExemplo> {
  final _formKey = GlobalKey<FormState>();
  final _nomeAnimal = TextEditingController();
  final _idade = TextEditingController();
  final List<String> _roles = ['cachorro', 'gato', 'outro'];
  String? _especie;
  bool _aceitarTermos = false;
  final List<Pet> _petsCadastrados = [];


void _adicionarPet() {
if (_formKey.currentState!.validate()) {
setState(() {
_petsCadastrados.add(Pet(
nome: _nomeAnimal.text,
especie: _especie!,
idade: int.parse(_idade.text),
eCastrado: _aceitarTermos,
));
});
//_limparFormulario();
}
}
void _cadastrarPet() {
  if (_formKey.currentState!.validate()) {
    // 1. Instancia o objeto com os dados do formulário
    final pet = Pet(
      nome: _nomeAnimal.text,
      especie: _especie!,
      idade: int.parse(_idade.text),
      eCastrado: _aceitarTermos,
    );

    // 2. Navega para a segunda tela enviando o parâmetro
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PerfilPetPage(pet: pet),
      ),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Rápido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeAnimal,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nome Animal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ) {
                    return 'coloque um nome!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
            DropdownButtonFormField<String>(
            initialValue: _especie, 
            hint: const Text('Selecione uma especie'),
            decoration: const InputDecoration(
              labelText: 'selecione uma especie',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            items: _roles.map((String role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _especie = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a role';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
                controller: _idade,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'idade',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (int.tryParse(value!) == null|| int.parse(value) < 0 ) {
                    return 'coloque uma idade valida!';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: const Text('Aceitar termos'),
                subtitle: const Text('li e concordo com os termos'
                ),
                 value: _aceitarTermos,
                 onChanged: (novoValor) {
                  setState( () {
                    _aceitarTermos = novoValor ?? false;
                   });
                 }
              
              ),
              ElevatedButton(
                onPressed: _cadastrarPet, 
                child: Text('adicionar'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
