import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yz_app_jam/common/widgets/post_card.dart';
import 'package:yz_app_jam/ui/paylasim/help_view_model.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  Stream<QuerySnapshot> postsStream = FirebaseFirestore.instance
      .collection('Post')
      .orderBy('timestamp', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpViewModel>.reactive(
        viewModelBuilder: () => HelpViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) => StreamBuilder<QuerySnapshot>(
              stream: postsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      Timestamp timestamp = data['timestamp'];
                      DateTime dateTime = timestamp.toDate();
                      String formattedDate =
                          '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                      String formattedTime =
                          '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: PostCard(
                          username: data['username'],
                          email: data['email'],
                          text: data['text'],
                          cinsiyet: data['cinsiyet'],
                          formattedTime: formattedTime,
                          formattedDate: formattedDate,
                        ),
                      );
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            ));
  }
}
