import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yz_app_jam/ui/main/main_view.dart';

class BagView extends StatefulWidget {
  const BagView({super.key});

  @override
  State<BagView> createState() => _BagViewState();
}

class _BagViewState extends State<BagView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Çanta İçeriği'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainView()),
            );
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<User?>(
      future: _getCurrentUser(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Bir hata oluştu: ${snapshot.error}'),
          );
        } else {
          User? currentUser = snapshot.data;
          if (currentUser == null) {
            return Center(
              child: Text('Kullanıcı bulunamadı'),
            );
          }
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream:
                _firestore.collection('users').doc(currentUser.uid).snapshots(),
            builder: (context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Bir hata oluştu: ${snapshot.error}'),
                );
              } else {
                var labels = snapshot.data!.data()?['labels'] as List<dynamic>;
                List<String> bagContents = [];
                for (var label in labels) {
                  String labelText = extractLabelText(label.toString());
                  bagContents.add(labelText);
                }
                return ListView.builder(
                  itemCount: bagContents.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.label),
                      title: Text(bagContents[index]),
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  String extractLabelText(String originalText) {
    RegExp regExp = RegExp(r'Label: (.*?),');
    Match? match = regExp.firstMatch(originalText);
    if (match != null) {
      return match.group(1)!;
    } else {
      return "No match found";
    }
  }

  Future<User?> _getCurrentUser() async {
    return _auth.currentUser;
  }
}
