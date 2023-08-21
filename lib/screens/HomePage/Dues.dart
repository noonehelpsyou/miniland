import 'package:flutter/material.dart';
import 'package:miniland/widgets/dues_card.dart';

import '../../function/esewa.dart';

class DuesScreen extends StatelessWidget {
  const DuesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.redAccent,
            pinned: false,
            floating: true,
            leading: Icon(Icons.menu),
            title: Text("Dues"),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: size.height * 0.9, // 90% of screen height
              child: Stack(
                children: [
                  Container(
                    child: DuesCard(
                        month: 'November',
                        amount: '29,989',
                        date: '8 Nov 2023',
                        status: 'Pending'),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: FractionalTranslation(
                      translation: Offset(0, 0.5), // Adjust the vertical shift
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],

                          color: Colors.white, // Adjust the color as needed
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        height: size.height * 0.1, // 10% of screen height
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Total Amount"),
                                  Text(
                                    "₹29,989",
                                    textScaleFactor: 1.5,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.3,
                                height: size.width * 0.1,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    Esewa esewa = Esewa(amount: '600');
                                    esewa.pay();
                                  },
                                  child: Text(
                                    "Pay All",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          // Other slivers go here
        ],
      ),
    );
  }
}
