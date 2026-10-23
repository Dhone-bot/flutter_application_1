import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FormularioExemplo()));

class FormularioExemplo extends StatefulWidget {
  const FormularioExemplo({super.key});

  @override
  State<FormularioExemplo> createState() => _FormularioExemploState();
}

class _FormularioExemploState extends State<FormularioExemplo> {
  final _formKey = GlobalKey<FormState>();
  final _nomeAnimal = TextEditingController();
  final _idade = TextEditingController();
  final List<String> _roles = ['cachorro', 'gato', 'outro'];
  String? _selectedRole;
  bool _aceitarTermos = false;

  void _submeterFormulario() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('validando')),
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
            initialValue: _selectedRole, 
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
                _selectedRole = newValue;
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
                onPressed: _submeterFormulario, 
                child: Text('submit'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
