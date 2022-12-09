import 'package:cryptocurrency/view_models/onboard_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<OnBoardScreenViewModel>(
        create: (context) => OnBoardScreenViewModel(),
        builder: (context, child) => Scaffold(
              body: Provider.of<OnBoardScreenViewModel>(context,listen: false)
                  .buildStreamBuilder(),
            ));
  }
}
