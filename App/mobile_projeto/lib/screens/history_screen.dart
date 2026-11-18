import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../core/app_colors.dart';
import '../controllers/network_test_controller.dart';

class HistoryScreen extends StatelessWidget {
  final NetworkTestController controller = Get.find<NetworkTestController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        title: Text('Histórico de Testes', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: AppColors.primaryNeon),
      ),
      body: Obx(() {
        if (controller.history.isEmpty) {
          return Center(child: Text('Nenhum teste realizado.', style: TextStyle(color: AppColors.textSecondary)));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.history.length,
          itemBuilder: (context, index) {
            final item = controller.history[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border(left: BorderSide(color: AppColors.primaryNeon, width: 4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['data']!, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMiniMetric('Ping', item['ping']!),
                      _buildMiniMetric('Down', item['down']!),
                      _buildMiniMetric('Up', item['up']!),
                    ],
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildMiniMetric(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }
}