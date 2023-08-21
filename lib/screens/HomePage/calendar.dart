import 'package:flutter/material.dart';
import 'package:flutter_bs_ad_calendar/flutter_bs_ad_calendar.dart';
import 'package:nepali_utils/nepali_utils.dart';

class Content {
  String? title;

  Content({
    this.title,
  });
}

class EventCalendar extends StatefulWidget {
  const EventCalendar({Key? key}) : super(key: key);

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  late CalendarType _calendarType;
  late List<Event> _events;
  DateTime? _selectedDate;
  List<Event>? _selectedDateEvents;

  @override
  void initState() {
    super.initState();

    _calendarType = CalendarType.bs;
    _events = _getEvents();
  }

  List<Event> _getEvents() {
    return [
      Event(
        date: DateTime(2080, 04, 14),
        event: Content(title: 'Event'),
      ),
      Event(
        date: DateTime(2023, 07, 16),
        event: Content(title: 'Event 01'),
      ),
      Event(
        date: DateTime(2080, 04, 01),
        event: Content(title: 'Event 02'),
      ),
      Event(
        date: DateTime(2080, 04, 14),
        event: Content(title: 'Event 03'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Calendar with Events'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Add your drawer open functionality here
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_calendarType == CalendarType.ad) {
                setState(() => _calendarType = CalendarType.bs);
              } else {
                setState(() => _calendarType = CalendarType.ad);
              }
            },
            child: Text(_calendarType == CalendarType.bs ? 'En' : 'ने'),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.withOpacity(.7)),
            child: Icon(Icons.person),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              double calendarHeight = constraints.maxHeight;
              return Container(
                margin: EdgeInsets.all(10),
                height: calendarHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: FlutterBSADCalendar(
                  primaryColor: Colors.redAccent,
                  calendarType: _calendarType,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  todayDecoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(.9),
                      borderRadius: BorderRadius.circular(10)),
                  selectedDayDecoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)),
                  lastDate: DateTime(2043),
                  mondayWeek: false, // true is for Monday, false is  for Sunday
                  eventColor: Colors.deepPurple,
                  weekendDays: const [
                    DateTime.saturday,
                  ],

                  holidayColor: Colors.redAccent,

                  events: _events,
                  onMonthChanged: (date, events) {
                    setState(() {
                      _selectedDate = date;
                      _selectedDateEvents = events;
                    });
                  },
                  onDateSelected: (date, events) {
                    setState(() {
                      _selectedDate = date;
                      _selectedDateEvents = events;
                      print(_selectedDateEvents);
                    });
                  },
                ),
              );
            }),
          ),
          SizedBox(
            height: 250,
            child: _selectedDateEvents !=
                    null // Check if the eventList is not null
                ? ListView.builder(
                    itemCount: _selectedDateEvents!.length,
                    itemBuilder: (context, index) {
                      Event event = _selectedDateEvents![index];

                      return Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${event.event.title}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Date: ${event.date?.year.toString()}-${event.date?.month.toString()}-${event.date?.day.toString()}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                        'No events found'), // Display a message when eventList is null
                  ),
          ),
        ],
      ),
    );
  }
}
