import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style_hub/presentation/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style Hub'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Siz ${controller.count} marta bosdingiz')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.count.value++;
              },
              child: const Text('Bosing'),
            ),
          ],
        ),
      ),
    );
  }
}
