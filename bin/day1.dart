// ? question1: How many measurements are larger than the previous measurement?
// ? question2: Consider sums of a three-measurement sliding window. How many sums are larger than the previous sum?

import 'dart:io';

void main() {
  // final File file = File('data/day1input1example.txt');
  final File file = File('data/day1input1.txt');
  final List<String> measurementsData = file.readAsLinesSync();
  final List<int> measurements =
      measurementsData.map((e) => int.parse(e)).toList();

  countIncremets(measurements);
  countWindowsIncrements(measurements);
}

void countIncremets(List<int> measurements) {
  int increasedCounter = 0;

  print('${measurements[0]} (N/A - no previous measurement)');
  // the loop starts from the 2nd element in the list
  for (int i = 1; i < measurements.length; i++) {
    if (measurements[i] > measurements[i - 1]) {
      increasedCounter++;
      print('${measurements[i]} (increased)');
    } else {
      print('${measurements[i]} (no change or decreased)');
    }
  }
  print(
      'there are $increasedCounter measurements that are larger than the previous measurement.');
}

void countWindowsIncrements(List<int> measurements) {
  int sumIncreasedCounter = 0;

  print(
      '${measurements[0] + measurements[1] + measurements[2]} (N/A - no previous sum)');
  // the loop starts from the 2nd element in the list and stops in the antepenultimate.
  for (int i = 1; i < measurements.length - 2; i++) {
    final int currentWindowSum =
        measurements[i] + measurements[i + 1] + measurements[i + 2];
    final int lastWindowSum =
        measurements[i - 1] + measurements[i] + measurements[i + 1];

    if (currentWindowSum > lastWindowSum) {
      sumIncreasedCounter++;
      print('$currentWindowSum (increased)');
    } else if (currentWindowSum == lastWindowSum) {
      print('$currentWindowSum (no change)');
    } else {
      print('$currentWindowSum (decreased)');
    }
  }

  print(
      'there are $sumIncreasedCounter sums that are larger than the previous sum.');
}
