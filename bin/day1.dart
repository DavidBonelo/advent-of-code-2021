import 'dart:io';

void main() {
  File file = File('data/day1input1.txt');
  List<String> depthMeasurements = file.readAsLinesSync();
  int incrementedCounter = 0;

  print('${depthMeasurements[0]} (N/A - no previous measurement)');

  for (int i = 1; i < depthMeasurements.length; i++) {
    final int currentMeasurement = int.parse(depthMeasurements[i]);
    final int lastMeasurement = int.parse(depthMeasurements[i - 1]);

    if (currentMeasurement > lastMeasurement) {
      incrementedCounter++;
      print('$currentMeasurement (incremented)');
    } else {
      print('$currentMeasurement (same or decreased)');
    }
  }
  print('there are $incrementedCounter measurements that are larger than the previous measurement.');
}
