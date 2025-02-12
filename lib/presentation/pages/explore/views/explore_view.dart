import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Center(
        child: Text('Explore Screen '),
      ),
    );
  }
}
