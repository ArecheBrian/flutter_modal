import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class RadioButtonCubit extends Cubit<String> {
  RadioButtonCubit() : super('Opción 1');

  void selectRadioButton(String value) {
    emit(value);
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modal con Radio Buttons (Cubit)'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _mostrarModal(context);
          },
          child: Text('Mostrar Modal'),
        ),
      ),
    );
  }

  void _mostrarModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => RadioButtonCubit(),
          child: RadioButtonModal(),
        );
      },
    );
  }
}

class RadioButtonModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return BlocBuilder<RadioButtonCubit, String>(
      builder: (context, selectedOption) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Opción 1'),
                leading: Radio(
                  value: 'Opción 1',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    context.read<RadioButtonCubit>().selectRadioButton(value!);
                  },
                ),
              ),
              ListTile(
                title: Text('Opción 2'),
                leading: Radio(
                  value: 'Opción 2',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    context.read<RadioButtonCubit>().selectRadioButton(value!);
                  },
                ),
              ),
              if (selectedOption == 'Opción 2')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildCountryDropdown(),
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el modal
                  // Realiza alguna acción con la opción seleccionada
                  print('Opción seleccionada: $selectedOption');
                },
                child: Text('Aceptar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryDropdown() {
    return Column(
      children: [
        Text('Selecciona un país:'),
        DropdownButton<String>(
          value: 'Selecciona', // Puedes establecer un valor predeterminado
          onChanged: (String? newValue) {
            // Puedes realizar acciones adicionales al cambiar el valor
          },
          items: <String>['Selecciona', 'País 1', 'País 2', 'País 3']
              .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

