import 'dart:io';
import 'dart:async';
import 'dart:math';

Future<void> main() async {
  const host = '127.0.0.1';
  const port = 4040;

  final socket = await Socket.connect(host, port);
  print('Conectado ao servidor em $host:$port');

  final random = Random();

  Timer.periodic(Duration(seconds: 10), (timer) {
    double temperatura = 20 + random.nextDouble() * 15; // 20°C a 35°C
    String mensagem = temperatura.toStringAsFixed(2);

    socket.write(mensagem + '\n');
    print('Enviado: $mensagem °C');
  });
}
