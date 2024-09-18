import 'package:flutter/material.dart';
import 'page.dart'; // Asegúrate de importar el archivo que contiene la página de perfil
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detalles del Usuario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _selectedIndex = 0;

  // Función para cambiar de página
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Verificar si se selecciona el ítem de perfil y navegar
    if (index == 1) { // El índice de "Perfil"
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageExt()),
      );
    }
  }

  // Función para hacer una llamada
  _makePhoneCall() async {
    final Uri url = Uri(scheme: 'tel', path: '+9613293441'); // Reemplaza con el número deseado
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('El emulador no soporta llamadas.');
    }
  }

  // Función para enviar mensaje
  _sendMessage() async {
    final Uri url = Uri(scheme: 'sms', path: '+9613293441'); // Reemplaza con el número deseado
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se puede enviar el mensaje a $url';
    }
  }

  // Función para abrir enlace de repositorio
  _openRepository() async {
    final Uri url = Uri.parse('https://github.com/edrei01/flores203140.git'); // Reemplaza con tu enlace
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se puede abrir el enlace a $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://www.example.com/imagen.jpg'), // Reemplaza con la URL de la imagen
            ),
            SizedBox(height: 16),
            Text(
              'Edrei Alvarez',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Matrícula: 203140',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _makePhoneCall,
              icon: Icon(Icons.call),
              label: Text('Llamar'),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _sendMessage,
              icon: Icon(Icons.message),
              label: Text('Mensaje'),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _openRepository,
              icon: Icon(Icons.link),
              label: Text('Repositorio'),
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

