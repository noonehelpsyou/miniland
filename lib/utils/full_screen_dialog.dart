import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/community_model.dart';

class FullScreenDialog extends StatelessWidget {
  TextEditingController _messageController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Message'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(
                          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Shahid Amin",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                ],
              ),
              SizedBox(height: 5),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _messageController,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Enter Message',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 40,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade100),
                      child: IconButton(
                          onPressed: () {
                            _pickImages(context);
                          },
                          icon: Icon(CupertinoIcons.photo_fill_on_rectangle_fill)),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: 40,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade100),
                      child: IconButton(
                          onPressed: () {

                          },
                          icon: Icon(CupertinoIcons.doc_text_fill)),
                  ),],

              ),
              SizedBox(height: 15,),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String? currentUserUUID = await getCurrentUserUUID();
                      CommunityMessage message = CommunityMessage(
                        uuid: currentUserUUID,
                        message: _messageController.text,
                        profileUrl: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400",
                        username: "Shahid Amin"
                      );

                      await sendMessageToFirebase(message);
                      Navigator.pop(context);
                    }
                  },

                  style: ElevatedButton.styleFrom(primary: Colors.redAccent, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                  child: Text('Post', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





List<XFile> selectedImages = [];

void _pickImages(BuildContext context) async {
  var status = await Permission.photos.request();

  if (status.isGranted) {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images != null) {
      selectedImages = images;
    }
  } else if (status.isDenied) {
    // Handle denied permission
  } else if (status.isPermanentlyDenied) {
    // Handle permanently denied permission
  }
}


void _sendFilesToFirebase() async {
  // Add your Firebase Storage upload logic here
}

Future<String?> getCurrentUserUUID() async {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.uid;
}
