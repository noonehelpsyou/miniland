import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniland/widgets/duesCard_widget.dart';

class DuesCard extends StatelessWidget {
  final String month;
  final String date;
  final String status;
  final String amount;

   DuesCard({super.key, required this.month, required this.date, required this.status, required this.amount});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            DuesCardWidget(icon: CupertinoIcons.calendar, name: "Month : ${month}"),
            SizedBox(height: 10),
            DuesCardWidget(icon: Icons.payments, name: "Payment Date : ${date}"),
            SizedBox(height: 10),
            DuesCardWidget(icon: CupertinoIcons.time_solid, name: "Status : ${status}"),
            Divider(color: Colors.redAccent.withOpacity(0.1)),
            DuesCardWidget(icon: CupertinoIcons.money_dollar_circle_fill, name: "Total : ₹${amount}"),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Adjust padding as needed
                minimumSize: Size(double.infinity, 0), // Make width match container's width
              ),
              child: Text(
                "Pay",
                style: TextStyle(color: Colors.white),
              ),
            )

          ],
        ),
      ),
    );
  }
}
