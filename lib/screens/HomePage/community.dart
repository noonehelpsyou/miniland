import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miniland/widgets/community_card.dart';

import '../../utils/full_screen_dialog.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBarWithActions(),
          ];
        },
        body: StreamBuilder<QuerySnapshot>(
          stream: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error fetching data');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final documents = snapshot.data!.docs;

            if (documents.isEmpty) {
              return Center(child: Text('No data'));
            }

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final data = document.data() as Map<String, dynamic>;
                final documentId = document.id;
                final message = data['message'] as String;
                final profileUrl = data['profileUrl'] as String;
                final username = data['username'] as String;

                if (message.isNotEmpty && username.isNotEmpty) {
                  return CommunityCard(
                    documentId: documentId,
                    profileUrl: profileUrl,
                    username: username,
                    message: message,
                  );
                } else {
                  return ListTile(
                    title: Text('Leave Type: Invalid Data'),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class SliverAppBarWithActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.redAccent,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          // Open drawer
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // Handle edit action
            _openFullScreenDialog(context);
          },
        ),
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // Handle profile action
          },
        ),
      ],
      title: Text('Community'),
      floating: true,
    );
  }
}

// Full screen dialog
void _openFullScreenDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FullScreenDialog();
    },
    barrierDismissible: false,
  );
}

Stream<QuerySnapshot> getData() {
  return FirebaseFirestore.instance.collection('community').snapshots();
}
