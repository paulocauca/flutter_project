import 'package:apportho/pages/auth.dart';
import 'package:apportho/pages/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicaPage extends StatelessWidget{


  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();

    } catch (e) {
      print(e);

    }

  }


  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return ListTile(
      title: Row(children: <Widget>[
        Expanded(child: Text(
          document['Nome'],
          style: Theme.of(context).textTheme.headline,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xffdddff),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text('Bha', style: Theme.of(context).textTheme.display1,
          ),
        ),
      ],
     ),
    );
  }
//where("uid", isEqualTo : auth.currentUser())
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

  
    print("TESTE");

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Clinicas'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Sair', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context)),
        ],
      ),
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('clinica').snapshots(), 
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) 
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Carregando');
            default:
              return ListView.builder(
              itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => 
                _buildListItem(context, snapshot.data.documents[index]),
          );
          }
        }),

      );
  }

}
