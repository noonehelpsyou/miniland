import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/leave_history_card.dart';

class LeaveHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userUUID = getCurrentUserUUID(); // Get the current user's UUID

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
          ],
          title: Text('Leave History'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Approved'),
              Tab(text: 'Pending'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LeaveStatusSection(status: 'approved', userUUID: userUUID),
            LeaveStatusSection(status: 'pending', userUUID: userUUID),
            LeaveStatusSection(status: 'rejected', userUUID: userUUID),
          ],
        ),
      ),
    );
  }
}

class LeaveStatusSection extends StatelessWidget {
  final String status;
  final String userUUID;

  LeaveStatusSection({required this.status, required this.userUUID});

  Stream<QuerySnapshot> getDataByStatusAndUUID(String status, String userUUID) {
    return FirebaseFirestore.instance
        .collection('leave_application')
        .where('status', isEqualTo: status)
        .where('UUID', isEqualTo: userUUID)
        .snapshots();
  }

  Future<void> deleteData(String documentId) {
    return FirebaseFirestore.instance
        .collection('leave_application')
        .doc(documentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getDataByStatusAndUUID(status, userUUID),
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
          return Center(child: Text('No $status leaves'));
        }

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final document = documents[index];
            final data = document.data() as Map<String, dynamic>;
            final documentId = document.id;
            final leaveDateFrom = data['leave_date_from'] as Timestamp?;
            final leaveDateTo = data['leave_date_to'] as Timestamp?;
            final applyDateTo = data['timestamp'] as Timestamp?;

            if (leaveDateFrom != null && leaveDateTo != null && applyDateTo != null) {
              final leaveFromDate = leaveDateFrom.toDate();
              final leaveToDate = leaveDateTo.toDate();
              final applyDate = applyDateTo.toDate();

              final leaveType = data['leave_type'] as String;
              final reason = data['reason'] as String;

              return LeaveHistoryCard(status: status,reason: reason,fromDate: "${leaveFromDate.year.toString()}-${leaveFromDate.month.toString()}-${leaveFromDate.day.toString()}" ,toDate: "${leaveToDate.year.toString()}-${leaveToDate.month.toString()}-${leaveToDate.day.toString()}",applyDate: '${applyDate.year.toString()}-${applyDate.month.toString()}-${applyDate.day.toString()}',type: leaveType,documentId: documentId,
                onDelete: deleteData,);

            } else {
              return ListTile(
                title: Text('Leave Type: Invalid Data'),
              );
            }
          },
        );
      },
    );
  }
}

String getCurrentUserUUID() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    // Return a default value or handle the case when the user is not signed in
    return ''; // You can return any default value you prefer
  }
}







//LeaveHistoryCard(status: status,reason: reason,fromDate: "${leaveFromDate.year.toString()}-${leaveFromDate.month.toString()}-${leaveFromDate.day.toString()}" ,toDate: "${leaveToDate.year.toString()}-${leaveToDate.month.toString()}-${leaveToDate.day.toString()}",applyDate: '${applyDate.year.toString()}-${applyDate.month.toString()}-${applyDate.day.toString()}',type: leaveType,);
// final applyDateTo = data['timestamp'] as Timestamp?;