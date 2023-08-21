import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miniland/screens/leave_history.dart';

import '../utils/diaLOG.dart';

class ApplyForLeaveScreen extends StatefulWidget {
  @override
  _ApplyForLeaveScreenState createState() => _ApplyForLeaveScreenState();
}

class _ApplyForLeaveScreenState extends State<ApplyForLeaveScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedLeaveType;
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _reason;
  final userUUID = getCurrentUserUUID();

  List<String> _leaveTypes = [
    'Sick Leave',
    'Vacation',
    'Personal Leave',
    'Other'
  ];
  final reasonController = TextEditingController();

  @override
  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_fromDate == null || _toDate == null) {
        // If From Date or To Date is not selected, show a validation error.
        Utils.showAlertDialog(context, 'Validation Error',
            'Please select both From Date and To Date.');
        return;
      }
      // Add your Firestore collection path
      final CollectionReference leaveApplications =
          FirebaseFirestore.instance.collection('leave_application');

      // Add the data to Firestore
      try {
        // ... Your existing code ...

        // Add the data to Firestore
        await leaveApplications.add({
          'leave_type': _selectedLeaveType,
          'leave_date_from': _fromDate != null
              ? Timestamp.fromDate(
                  _fromDate!) // Convert DateTime to Firestore Timestamp
              : null,
          'leave_date_to': _toDate != null
              ? Timestamp.fromDate(
                  _toDate!) // Convert DateTime to Firestore Timestamp
              : null,
          'reason': reasonController.text,
          'timestamp':
              FieldValue.serverTimestamp(), // Add the current date and time
          'status': "pending",
          'UUID': userUUID
        });
        // After data is successfully uploaded, clear the form fields.
        setState(() {
          _selectedLeaveType = null;
          _fromDate = null;
          _toDate = null;
          reasonController.clear();
        });
        Utils.showSnackbar(context, "Leave Application Submited Successfully");
      } catch (e) {
        print('Error uploading data to Firestore: $e');
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 1,
        title: Text('Apply for Leave'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Apply Leave Date",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now())
                                  .toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              color: Color(0xFF8f8f8f).withOpacity(.7),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 16.0),
                Text(
                  "Leave Type",
                  style: TextStyle(color: Colors.grey),
                ),
                DropdownButtonFormField<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // Border color when enabled
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Leave Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  value: _selectedLeaveType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLeaveType = value!;
                    });
                  },
                  items: _leaveTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a leave type.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text("Leave Date", style: TextStyle(color: Colors.grey)),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xFFf4f4f4),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: Color(0xFF8f8f8f).withOpacity(.7),
                      ),
                      InkWell(
                        onTap: () => _selectFromDate(context),
                        child: Container(
                            width: 120,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color(0xFF8f8f8f).withOpacity(.1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                                _fromDate == null
                                    ? 'From'
                                    : DateFormat('yyyy-MM-dd')
                                        .format(_fromDate!),
                                textAlign: TextAlign.center)),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF8f8f8f).withOpacity(.7),
                      ),
                      InkWell(
                        onTap: () => _selectToDate(context),
                        child: Container(
                            width: 120,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color(0xFF8f8f8f).withOpacity(.1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                                _toDate == null
                                    ? 'To'
                                    : DateFormat('yyyy-MM-dd').format(_toDate!),
                                textAlign: TextAlign.center)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Reason", style: TextStyle(color: Colors.grey)),
                TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    hintText: 'Reason',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // Border color when enabled
                        borderRadius: BorderRadius.circular(8)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignLabelWithHint: true, // Align hint to top left
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    setState(() {
                      _reason = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the reason.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                SizedBox(
                  width: double.infinity, // Full width
                  height: 50, // Desired height
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    child: Text(
                      'Apply Leave',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeaveHistory())),
                        child: Text("Leave List"))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _fromDate) {
      setState(() {
        _fromDate = pickedDate;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _toDate) {
      setState(() {
        _toDate = pickedDate;
      });
    }
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
