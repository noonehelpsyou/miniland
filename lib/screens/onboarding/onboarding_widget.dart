import 'package:flutter/material.dart';

import '../../models/models_onboarding.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.image),
            height: model.height * 0.5,
          ),
          Column(
            children: [
              Text(model.title,
                  style: TextStyle(
                      fontFamily: "Poppins-bold",
                      fontSize: 25,
                      color: model.txtColor)),
              Text(
                model.subTitile,
                textAlign: TextAlign.center,
                style: TextStyle(color: model.txtColor),
              ),
            ],
          ),
          Text(
            model.counterText,
            style: TextStyle(fontFamily: "medium", color: model.txtColor),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
