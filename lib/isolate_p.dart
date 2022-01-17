import 'dart:isolate';

late ReceivePort receivePort;
late SendPort sendPort;

entryPoint(SendPort sendPort) async {
  ReceivePort receivePort = ReceivePort();

  sendPort.send(receivePort.sendPort);

  await for(var msq in receivePort) {
    var data = msq[0];
    SendPort replyTo = msq[1];
    replyTo.send(data);

  }
}

Future sendReceive(msq){
  ReceivePort response = ReceivePort();
  sendPort.send([msq, response.sendPort]);
  return response.first;
}