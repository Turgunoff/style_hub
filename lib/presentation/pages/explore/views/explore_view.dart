import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Go to Favorites'),
        ),
      ),
    );
  }
}
