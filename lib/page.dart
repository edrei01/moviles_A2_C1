import 'package:flutter/material.dart';
import 'main.dart'; // Importa tu archivo main.dart para poder navegar a la página principal

void main() {
  runApp(PageExt());
}

class PageExt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePageExt(), // Renombramos esta clase para no confundirla con MyHomePage del archivo main.dart
    );
  }
}

class MyHomePageExt extends StatefulWidget {
  @override
  _MyHomePageExtState createState() => _MyHomePageExtState();
}

class _MyHomePageExtState extends State<MyHomePageExt> {
  String _inputText = "";
  int _selectedIndex = 1; // Índice seleccionado para el BottomNavigationBar
  final TextEditingController _textController = TextEditingController();

  void _handleButtonPress() {
    setState(() {
      _inputText = _textController.text;
    });
  }

  // Función que maneja el cambio de página en el BottomNavigationBar
  void _onItemTapped(int index) {
    if (index == 0) { // Si se selecciona "Inicio"
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()), // Redirige a la pantalla principal
      );
    } else {
      setState(() {
        _selectedIndex = index; // Actualiza el índice si no es "Inicio"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otra Página'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(controller: _textController),
            SizedBox(height: 20),
            CustomButton(onPressed: _handleButtonPress),
            SizedBox(height: 20),
            Text(
              'Input: $_inputText',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,  // Maneja el clic en los ítems
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}

// Clase para estilizar el botón
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        'Press Me',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

// Clase para el TextField
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  CustomTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter something',
        hintText: 'Type here',
      ),
    );
  }
}
