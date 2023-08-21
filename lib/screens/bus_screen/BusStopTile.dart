import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusStopTile extends StatelessWidget {
  final String busStop;

  BusStopTile({
    super.key,
    required this.busStop,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.redAccent.withOpacity(0.1),
            ),
            child: Center(
                child: Icon(
              Icons.location_on_outlined,
              color: Colors.redAccent,
            ))),
        title: Text(busStop));
  }
}
