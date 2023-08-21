import 'package:flutter/material.dart';

import '../utils/diaLOG.dart';

class LeaveHistoryCard extends StatelessWidget {
  final String status;
  final String fromDate;
  final String toDate;
  final String applyDate;
  final String type;
  final String reason;
  final String documentId;
  final Function(String) onDelete;

  const LeaveHistoryCard({
    required this.status,
    required this.type,
    required this.fromDate,
    required this.applyDate,
    required this.toDate,
    required this.reason,
    required this.documentId,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Border radius (optional)
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 1, // Shadow spread radius (optional)
            blurRadius: 10, // Shadow blur radius (optional)
            offset:
                Offset(0, 2), // Shadow offset (horizontal, vertical) (optional)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child:
                      Text(type, style: TextStyle(color: Colors.white)),
                ),
                RichText(
                  text: TextSpan(
                      text: "Apply date : ",
                      style: TextStyle(
                          color: Colors.redAccent, fontFamily: "Poppins"),
                      children: <TextSpan>[
                        TextSpan(
                          text: applyDate,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            SizedBox(height: 10),
            IntrinsicHeight(
              child: Row(
                children: [
                  // container1
                  Container(
                    width: 2,
                    height: double.infinity,
                    // Set the height to occupy all available vertical space
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      reason,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: TextSpan(
                      text: "From : ",
                      style: TextStyle(
                          color: Colors.redAccent, fontFamily: "Poppins"),
                      children: <TextSpan>[
                        TextSpan(
                          text: fromDate,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                          ),
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "To : ",
                      style: TextStyle(
                          color: Colors.redAccent, fontFamily: "Poppins"),
                      children: <TextSpan>[
                        TextSpan(
                          text: toDate,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            SizedBox(height: 10),

            if (status == 'pending')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to delete the application?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  onDelete(documentId); // Call onDelete function here
                                  Navigator.pop(context); // Close the dialog after deletion
                                },
                                child: Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog if No is clicked
                                },
                                child: Text("No"),
                              )
                            ],
                          );
                        },
                      );


                    },
                    child: Text("Delete"),
                  ),
                ],
              ),

          ],
        ),
      ),
    );
  }
}
