import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:like_button/like_button.dart';

import '../utils/clickableText.dart';

class CommunityCard extends StatefulWidget {

  final String profileUrl;
  final String username;
  final String message;
  final String documentId;


   CommunityCard({super.key, required this.profileUrl, required this.username, required this.message, required this.documentId});

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  bool _isLiked = false;
  int _likeCount = 0;


  @override
  void initState() {
    super.initState();
    _fetchLikes(); // Call this function to fetch likes on widget initialization
  }

  Future<void> _fetchLikes() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final currentUserUUID = currentUser.uid;

      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('community')
          .doc(widget.documentId)
          .get();

      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      Map<String, bool>? likesData = data['likes'] as Map<String, bool>?;

      setState(() {
        _isLiked = likesData?.containsKey(currentUserUUID) ?? false;
        _likeCount = likesData?.length ?? 0; // Use the length of the map to get the count
      });
    }
  }


  Future<void> _updateLikes(String documentId, String currentUserUUID, bool isLiked) async {
    try {
      CollectionReference communityCollection =
      FirebaseFirestore.instance.collection('community');

      // Get the document reference
      DocumentReference docRef = communityCollection.doc(documentId);

      if (isLiked) {
        // Add the current user's UUID to likes
        await docRef.update({
          'likes.$currentUserUUID': true,
        });
      } else {
        // Remove the current user's UUID from likes
        await docRef.update({
          'likes.$currentUserUUID': FieldValue.delete(),
        });
      }
    } catch (error) {
      print('Error updating likes: $error');
    }
  }

  Future<bool> _onLikeButtonTapped(bool isLiked) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final currentUserUUID = currentUser.uid;

      setState(() {
        _isLiked = !_isLiked;
        if (_isLiked) {
          _likeCount++;
        } else {
          _likeCount--;
        }
        _updateLikes(widget.documentId, currentUserUUID, _isLiked); // Update the likes field
      });
    }
    return _isLiked;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.documentId);
    List<String> images = [
"https://images.unsplash.com/photo-1682686581551-867e0b208bd1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
"https://images.unsplash.com/photo-1682685797661-9e0c87f59c60?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
"https://images.unsplash.com/photo-1691118761157-4cc85bce479e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
"https://images.unsplash.com/photo-1682686581551-867e0b208bd1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",

    ];
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: NetworkImage(
                           widget.profileUrl),
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " • just now",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Icon(CupertinoIcons.ellipsis, color: Colors.grey.shade800),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
              child: ClickableText(textMessage: widget.message)), // Use the ClickableText widget here


          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    // border: Border.all()
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LikeButton(
                        isLiked: _isLiked,
                        likeCount: _likeCount,
                        onTap: _onLikeButtonTapped,
                        size: 30,
                        circleColor: CircleColor(start: Colors.redAccent, end: Colors.red),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.redAccent,
                          dotSecondaryColor: Colors.red,
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isLiked ?
                            CupertinoIcons.heart_fill :
                            CupertinoIcons.heart
                            ,
                            color: isLiked ? Colors.red : Colors.redAccent,
                            size: 20,
                          );
                        },
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   decoration: BoxDecoration(
          //     border: Border.all(),
          //         borderRadius: BorderRadius.circular(100)
          //   ),
          //   child: Text("Class 10"),
          // ),

    Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageStack(
              imageList: images,
              totalCount: images.length ,// If larger than images.length, will show extra empty circle
              imageRadius: 25, // Radius of each images
                backgroundColor: Colors.grey.shade100,
              imageBorderColor: Colors.white,
              extraCountTextStyle: TextStyle(color: Colors.grey),
              imageCount: 3, // Maximum number of images to be shown in stack
              imageBorderWidth: 1, // Border width around the images
              ),
              SizedBox(width: 10,),
              Text("Comments.."),
            ],
          ),


          Icon(CupertinoIcons.chat_bubble_2_fill)
        ],
      ),
    ),
          Container(
            height: 3,
            color: Colors.grey.shade100,
          ),
    ],
      ),
    );
  }
}