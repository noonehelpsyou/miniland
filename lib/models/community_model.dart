import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityMessage {
  final String? uuid;
  final String? message;
  final String? username;
  final List<String>? imageUrls;
  final String? profileUrl;
  final List<String>? likes;

  CommunityMessage({
    this.uuid,
    this.message,
    this.username,
    this.imageUrls,
    this.profileUrl,
    this.likes,
  });

  // Factory method to create a CommunityMessage from a Firestore document
  factory CommunityMessage.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CommunityMessage(
      uuid: data['uuid'],
      message: data['message'],
      username: data['username'],
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      profileUrl: data['profileUrl'],
      likes: List<String>.from(data['likes'] ?? []),
    );
  }
}

Future<void> sendMessageToFirebase(CommunityMessage message) async {
  CollectionReference communityCollection =
  FirebaseFirestore.instance.collection('community');

  await communityCollection.add({
    'uuid': message.uuid,
    'message': message.message,
    'username': message.username,
    'imageUrls': message.imageUrls,
    'profileUrl': message.profileUrl,
    'likes': message.likes,
  });
}
