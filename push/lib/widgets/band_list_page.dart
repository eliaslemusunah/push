import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BandListPage extends StatefulWidget {
  @override
  _BandListPageState createState() => _BandListPageState();
}

class _BandListPageState extends State<BandListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _addVotedField();
  }

  Future<void> _addVotedField() async {
    final QuerySnapshot snapshot = await _firestore.collection('bands').get();
    final batch = _firestore.batch();

    snapshot.docs.forEach((document) {
      final data = document.data() as Map<String, dynamic>?;
      if (data != null && !data.containsKey('voted')) {
        batch.update(document.reference, {'voted': false});
      }
    });

    await batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Bandas'),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('bands').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final bands = snapshot.data!.docs;
            return ListView.builder(
              itemCount: bands.length,
              itemBuilder: (context, index) {
                final band = bands[index];
                final data = band.data() as Map<String, dynamic>?;
                return ListTile(
                  title: Text(
                    data?['bandName'] ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Álbum: ${data?['albumName'] ?? ''} (${data?['releaseYear'] ?? ''}), Votos: ${data?['votes'] ?? 0}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.check_circle,
                      color: data?['voted'] == true ? Colors.green : Colors.white,
                    ),
                    onPressed: () {
                      _firestore.runTransaction((transaction) async {
                        _firestore.runTransaction((transaction) async {
                   final bandSnapshot = await transaction.get(band.reference);
                  final bandsSnapshot = await _firestore.collection('bands').get();

                  for (final bandDoc in bandsSnapshot.docs) {
                  if (bandDoc.id != bandSnapshot.id) {
                  transaction.update(bandDoc.reference, {'voted': false});
      }
    }
    final newVotes = (bandSnapshot.data() as Map<String, dynamic>)['votes'] + 1;
    transaction.update(band.reference, {'votes': newVotes, 'voted': true});
                        });
                      });
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}