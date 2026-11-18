import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NetworkTestController extends GetxController {
  var isTesting = false.obs;
  var ping = '0 ms'.obs;
  var download = '0.0 Mbps'.obs;
  var upload = '0.0 Mbps'.obs;
  var latencia = '0 ms'.obs;
  var tracerouteStatus = 'Aguardando...'.obs;

  var history = [].obs;

  // Lógica para executar a bateria de testes simulada
  void runTests() async {
    isTesting.value = true;
    tracerouteStatus.value = 'Iniciando saltos...';
    ping.value = '--';
    download.value = '--';
    upload.value = '--';
    latencia.value = '--';

    await Future.delayed(const Duration(seconds: 2));
    ping.value = '24 ms';
    latencia.value = '25 ms';
    tracerouteStatus.value = 'google.com (142.250.191.46)';

    await Future.delayed(const Duration(seconds: 3));
    download.value = '350.5 Mbps';

    await Future.delayed(const Duration(seconds: 3));
    upload.value = '150.2 Mbps';
    tracerouteStatus.value = 'Concluído (8 saltos)';

    history.insert(0, {
      'data': DateTime.now().toString().substring(0, 16),
      'ping': ping.value,
      'down': download.value,
      'up': upload.value,
    });

    isTesting.value = false;
  }
}