import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniland/screens/bus_screen/BusStopTile.dart';

class BusRoute extends StatefulWidget {
  @override
  _BusRouteState createState() => _BusRouteState();
}

class _BusRouteState extends State<BusRoute> {
  bool _isExpanded = false;

  void _toggleCardExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Animated Card Example',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isExpanded ? 435 : 195.0,
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://via.placeholder.com/100'),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Rangeli - Sikti',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: Icon(_isExpanded
                              ? Icons.arrow_upward
                              : Icons.arrow_downward),
                          title: Text('Bus stops'),
                          onTap: _toggleCardExpansion,
                        ),
                        if (_isExpanded)
                          Column(
                            children: [
                              BusStopTile(busStop: "Jhingi Tole"),
                              BusStopTile(busStop: "Bherwa"),
                              BusStopTile(busStop: "Dainiya"),
                              BusStopTile(busStop: "HarichandGadi"),
                              BusStopTile(busStop: "Sikti"),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isExpanded ? 435 : 195.0,
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://via.placeholder.com/100'),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Rangeli - Sikti',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.arrow_downward),
                          title: Text('Bus stops'),
                          onTap: _toggleCardExpansion,
                        ),
                        if (_isExpanded)
                          Column(
                            children: [
                              BusStopTile(busStop: "Jhingi Tole"),
                              BusStopTile(busStop: "Bherwa"),
                              BusStopTile(busStop: "Dainiya"),
                              BusStopTile(busStop: "HarichandGadi"),
                              BusStopTile(busStop: "Sikti"),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isExpanded ? 435 : 195.0,
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://via.placeholder.com/100'),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Rangeli - Sikti',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.arrow_downward),
                          title: Text('Bus stops'),
                          onTap: _toggleCardExpansion,
                        ),
                        if (_isExpanded)
                          Column(
                            children: [
                              BusStopTile(busStop: "Jhingi Tole"),
                              BusStopTile(busStop: "Bherwa"),
                              BusStopTile(busStop: "Dainiya"),
                              BusStopTile(busStop: "HarichandGadi"),
                              BusStopTile(busStop: "Sikti"),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
