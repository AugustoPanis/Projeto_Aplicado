import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../core/app_colors.dart';
import '../controllers/network_test_controller.dart';
import 'history_screen.dart';

class DashboardScreen extends StatelessWidget {
  final NetworkTestController controller = Get.put(NetworkTestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        title: Text('Diagnóstico de Conexão', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: AppColors.primaryNeon),
            onPressed: () => Get.to(() => HistoryScreen()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() => GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMetricCard('Ping', controller.ping.value, Icons.speed),
                  _buildMetricCard('Download', controller.download.value, Icons.download),
                  _buildMetricCard('Upload', controller.upload.value, Icons.upload),
                  _buildMetricCard('Latência', controller.latencia.value, Icons.network_check),
                ],
              )),
            ),
            Obx(() => Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryNeon.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Traceroute', style: TextStyle(color: AppColors.textSecondary)),
                  SizedBox(height: 8),
                  Text(controller.tracerouteStatus.value, style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            )),
            const SizedBox(height: 24),
            Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNeon,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: controller.isTesting.value ? null : () => controller.runTests(),
              child: controller.isTesting.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('INICIAR BATERIA DE TESTES', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.router, color: AppColors.textSecondary, size: 40),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dispositivo Conectado', style: TextStyle(color: AppColors.textSecondary)),
              Text('ZTE ZXHN H118N', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryNeon, size: 32),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}