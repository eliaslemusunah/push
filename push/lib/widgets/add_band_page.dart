import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBandPage extends StatefulWidget {
  @override
  _AddBandPageState createState() => _AddBandPageState();
}

class _AddBandPageState extends State<AddBandPage> {
  final TextEditingController _bandNameController = TextEditingController();
  final TextEditingController _albumNameController = TextEditingController();
  final TextEditingController _releaseYearController = TextEditingController();

  @override
  void dispose() {
    _bandNameController.dispose();
    _albumNameController.dispose();
    _releaseYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Banda'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade700,
              Colors.deepPurple.shade300,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _bandNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la Banda',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.deepPurple.shade400,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _albumNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Álbum',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.deepPurple.shade400,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _releaseYearController,
                decoration: InputDecoration(
                  labelText: 'Año de Lanzamiento',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.deepPurple.shade400,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addBand(_bandNameController.text, _albumNameController.text,
                      int.parse(_releaseYearController.text));
                  Navigator.pop(context);
                },
                child: Text('Agregar Banda'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple.shade400,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addBand(String bandName, String albumName, int releaseYear) async {
  final CollectionReference bandsRef = FirebaseFirestore.instance.collection('bands');
  await bandsRef.add({
    'bandName': bandName,
    'albumName': albumName,
    'releaseYear': releaseYear,
    'votes': 0,
    'voted': false,
  });
}
}