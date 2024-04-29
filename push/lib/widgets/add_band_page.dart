import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddBandPage extends StatefulWidget {
  @override
  _AddBandPageState createState() => _AddBandPageState();
}

class _AddBandPageState extends State<AddBandPage> {
  final TextEditingController _bandNameController = TextEditingController();
  final TextEditingController _albumNameController = TextEditingController();
  final TextEditingController _releaseYearController = TextEditingController();

  File? _albumImage;

  @override
  void dispose() {
    _bandNameController.dispose();
    _albumNameController.dispose();
    _releaseYearController.dispose();
    super.dispose();
  }

  Future<void> _pickAlbumImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _albumImage = File(pickedImage.path);
      });
    }
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickAlbumImage,
                child: Text('Seleccionar Imagen del Álbum'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade400,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              _albumImage == null
                  ? Image.asset(
                      'assets/images/noimage.png',
                      height: 200,
                    )
                  : Image.file(
                      _albumImage!,
                      height: 200,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addBand(_bandNameController.text, _albumNameController.text,
                      int.parse(_releaseYearController.text), _albumImage);
                  Navigator.pop(context);
                },
                child: Text('Agregar Banda'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade400,
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

  Future<void> addBand(String bandName, String albumName, int releaseYear, File? albumImage) async {
    final CollectionReference bandsRef = FirebaseFirestore.instance.collection('bands');
    String albumImageUrl = '';

    if (albumImage != null) {
      final storageRef = FirebaseStorage.instance.ref().child('album_images/${albumName.replaceAll(' ', '_')}.jpg');
      await storageRef.putFile(albumImage);
      albumImageUrl = await storageRef.getDownloadURL();
    }

    await bandsRef.add({
      'bandName': bandName,
      'albumName': albumName,
      'releaseYear': releaseYear,
      'votes': 0,
      'voted': false,
      'albumImageUrl': albumImageUrl,
    });
  }
}