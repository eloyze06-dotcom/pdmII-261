import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  const host = '127.0.0.1';
  const port = 4040;

  final server = await ServerSocket.bind(host, port);
  print('Servidor rodando em $host:$port');

  await for (Socket client in server) {
    print('Cliente conectado: ${client.remoteAddress.address}:${client.remotePort}');

    client.listen(
      (data) {
        final message = utf8.decode(data).trim();
        print('Temperatura recebida: $message °C');
      },
      onDone: () {
        print('Cliente desconectado');
        client.close();
      },
      onError: (error) {
        print('Erro: $error');
        client.close();
      },
    );
  }
}