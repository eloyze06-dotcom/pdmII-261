import 'dart:io';
import 'dart:convert';


void main() async {
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 8080);
  print('🚀 Servidor IoT iniciado na porta 8080');
  print('📡 Aguardando conexões do dispositivo IoT...\n');

  server.listen((Socket client) {
    handleClient(client);
  });
}
void handleClient(Socket client) {
  client
      .cast<List<int>>()   // 👈 COLOCA AQUI
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((data) {
        try {
          final tempData = jsonDecode(data);
          print('🌡️  TEMPERATURA RECEBIDA: ${tempData['temperatura']}°C');
          print('⏰  Horário: ${DateTime.now().toString().substring(0, 19)}');
          print('📍 Dispositivo: ${tempData['dispositivo']}');
          print('---');
          
          // Envia confirmação de recebimento
          client.write('OK');
        } catch (e) {
          print('❌ Erro ao processar dados: $e');
        }
      }, onError: (error) {
        print('❌ Erro na conexão: $error');
        client.destroy();
      }, onDone: () {
        print('🔌 Conexão fechada');
        client.destroy();
      });
}