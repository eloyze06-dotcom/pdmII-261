import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'dart:async';

void main() async {
  print('🔥 Dispositivo IoT - Monitor de Temperatura');
  print('Iniciando conexão com servidor...\n');
  
  try {
    final socket = await Socket.connect('127.0.0.1', 8080);
    print('✅ Conectado ao servidor!');
    
    // Gerador de temperaturas simuladas (20-35°C)
    final random = Random();
    Timer.periodic(Duration(seconds: 10), (timer) async {
      final temperatura = 20 + random.nextDouble() * 15; // 20-35°C
      
      final dados = {
        'dispositivo': 'Sensor_Sala_01',
        'temperatura': temperatura.toStringAsFixed(2),
        'timestamp': DateTime.now().toIso8601String(),
      };
      
      final jsonData = jsonEncode(dados);
      socket.write('$jsonData\n');
      
      print('📤 Enviando: ${dados['temperatura']}°C - ${(dados['timestamp'] as String).substring(0, 19)}');
      
      // Aguarda confirmação
      await socket.first.timeout(Duration(seconds: 2));
    });
    
  } catch (e) {
    print('❌ Erro de conexão: $e');
  }
}