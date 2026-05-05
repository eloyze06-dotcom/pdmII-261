#!/bin/bash
echo "Iniciando Servidor IoT..."
dart run server.dart &
SERVER_PID=$!

sleep 2

echo "Iniciando Dispositivo IoT..."
dart run iot_device.dart
