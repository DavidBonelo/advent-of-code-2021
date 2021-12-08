// ? part1: You need to use the binary numbers in the diagnostic report to generate two new binary numbers (called the gamma rate and the epsilon rate). The power consumption can then be found by multiplying the gamma rate by the epsilon rate.
// ? part2: Use the binary numbers in your diagnostic report to calculate the oxygen generator rating and CO2 scrubber rating, then multiply them together. What is the life support rating of the submarine?

import 'dart:io';

void main() {
  final File file = File('data/day3input.txt');
  // final File file = File('data/day3input_example.txt');
  final List<String> report = file.readAsLinesSync();

  print(decodePowerConsumption(report));
  print(decodeLifeSupportRating(report));
}

Map decodePowerConsumption(List<String> report) {
  final List<List<String>> reportColumns = getColumns(report);

  final String gammaRateBinary = getGammaRate(reportColumns);
  final String epsilonRateBinary = getEpsilonRate(gammaRateBinary);
  final int gammaRate = int.parse(gammaRateBinary, radix: 2);
  final int epsilonRate = int.parse(epsilonRateBinary, radix: 2);
  final int powerConsumption = gammaRate * epsilonRate;
  return {
    'gammaRateBinary': gammaRateBinary,
    'epsilonRateBinary': epsilonRateBinary,
    'gammaRate': gammaRate,
    'epsilonRate': epsilonRate,
    'powerConsumption': powerConsumption
  };
}

List<List<String>> getColumns(List<String> report) {
  final int bitsLength = report[0].length;
  List<List<String>> reportColumns = [];
  // initialize reportColumns inner Lists
  // contains [bitsCol1, bitsCol2, bitsCol3, bitsCol4, bitsCol5...] bitsCols are also lists
  for (var i = 0; i < bitsLength; i++) {
    reportColumns.add([]);
  }

  // fills every bitsCol
  for (var line in report) {
    final lineBits = line.split('');

    for (var i = 0; i < bitsLength; i++) {
      reportColumns[i].add(lineBits[i]);
    }
  }
  return reportColumns;
}

/// Each bit in the gamma rate can be determined by finding the **most common bit in the corresponding position** of all numbers in the diagnostic report.
String getGammaRate(List<List<String>> reportColumns) {
  List<String> gammaRate = [];
  for (var i = 0; i < reportColumns.length; i++) {
    int counter0 = 0, counter1 = 0;
    for (var j = 0; j < reportColumns[0].length; j++) {
      if (reportColumns[i][j] == '0') {
        counter0++;
      } else {
        counter1++;
      }
    }
    if (counter0 > counter1) {
      gammaRate.add('0');
    } else {
      gammaRate.add('1');
    }
  }
  return gammaRate.join();
}

/// similar to Gamma Rate, but rather than use the most common bit, the least common bit from each position is used.\
/// in other words, the epsilon rate is the gamma rate but the bits are flipped
String getEpsilonRate(String gammaRateBinary) {
  return gammaRateBinary
      .split('')
      .map((e) {
        if (e == '0') {
          return '1';
        } else {
          return '0';
        }
      })
      .toList()
      .join();
}

Map decodeLifeSupportRating(List<String> report) {
  final String o2RateBinary = getLifeSuppRate(report, LifeSuppType.o2);
  final String co2RateBinary = getLifeSuppRate(report, LifeSuppType.co2);
  final int o2Rate = int.parse(o2RateBinary, radix: 2);
  final int co2Rate = int.parse(co2RateBinary, radix: 2);
  final int lifeSupportRate = o2Rate * co2Rate;
  return {
    'o2RateBinary': o2RateBinary,
    'co2RateBinary': co2RateBinary,
    'o2Rate': o2Rate,
    'co2Rate': co2Rate,
    'lifeSupportRate': lifeSupportRate
  };
}

// Both values are located using a similar process that involves filtering out values until only one remains. Before searching for either rating value, start with the full list of binary numbers from your diagnostic report and **consider just the first bit** of those numbers. Then:

// Keep only numbers selected by the bit criteria for the type of rating value for which you are searching. Discard numbers which do not match the bit criteria.
// If you only have one number left, stop; this is the rating value for which you are searching.
// Otherwise, repeat the process, considering the next bit to the right.

// The bit criteria depends on which type of rating value you want to find:

// To find **oxygen generator rating**, determine the **most common** value (0 or 1) in the current bit position, and keep only numbers with that bit in that position. If 0 and 1 are equally common, keep values with a 1 in the position being considered.
// To find **CO2 scrubber rating**, determine the **least common** value (0 or 1) in the current bit position, and keep only numbers with that bit in that position. If 0 and 1 are equally common, keep values with a 0 in the position being considered.
String getLifeSuppRate(List<String> report, LifeSuppType lifeSuppType) {
  // var reportCopy = report; // only gets a reference to the list object
  var reportCopy = report.toList();
  final bitsLengtht = reportCopy[0].length;

  for (var i = 0; i < bitsLengtht; i++) {
    // rebuild columns
    List<List<String>> reportColumns = getColumns(reportCopy);
    int bit0Counter = 0, bit1Counter = 0;
    List<int> bit0Indexes = [], bit1Indexes = [];

    for (var j = 0; j < reportColumns[0].length; j++) {
      if (reportColumns[i][j] == '0') {
        bit0Counter++;
        bit0Indexes.add(j);
      } else {
        bit1Counter++;
        bit1Indexes.add(j);
      }
    }
    // delete rows
    int removedCounter = 0;
    List<int> inexesToRemove = [];
    if (bit0Counter > bit1Counter) {
      inexesToRemove =
          lifeSuppType == LifeSuppType.o2 ? bit1Indexes : bit0Indexes;
    } else {
      inexesToRemove =
          lifeSuppType == LifeSuppType.o2 ? bit0Indexes : bit1Indexes;
    }
    for (var index in inexesToRemove) {
      reportCopy.removeAt(index - removedCounter);
      removedCounter++;
    }

    if (reportCopy.length == 1) break;
  }
  print(reportCopy.length);
  return reportCopy[0];
}

enum LifeSuppType { o2, co2 }
