// question1: Calculate the horizontal position and depth you would have after following the planned course. What do you get if you multiply your final horizontal position by your final depth?

// forward X increases the horizontal position by X units.
// down X increases the depth by X units.
// up X decreases the depth by X units.

// question2: same, but after reading the manual: In addition to horizontal position and depth, you'll also need to track a third value, aim, which also starts at 0. The commands also mean something entirely different than you first thought:

// down X increases your aim by X units.
// up X decreases your aim by X units.
// forward X does two things:
//     It increases your horizontal position by X units.
//     It increases your depth by your aim multiplied by X.

import 'dart:io';

void main() {
  final File file = File('data/day2input.txt');
  // final File file = File('data/day2input_example.txt');
  final List<String> commandsData = file.readAsLinesSync();
  final List<Map<String, int>> commands = parseCommands(commandsData);

  calculatePosition(commands);
  calculatePositionButAfterReadingTheManualLMAO(commands);
}

void calculatePosition(List<Map<String, int>> commands) {
  int depth = 0;
  int horizontalPosition = 0;

  for (var command in commands) {
    command.forEach((key, value) {
      switch (key) {
        case 'forward':
          horizontalPosition += value;
          break;
        case 'up':
          depth -= value;
          break;
        case 'down':
          depth += value;
          break;
      }
    });
  }

  print(
      'depth: $depth, hp: $horizontalPosition, multiplied: ${depth * horizontalPosition}');
}

void calculatePositionButAfterReadingTheManualLMAO(
    List<Map<String, int>> commands) {
  int depth = 0;
  int horizontalPosition = 0;
  int aim = 0;

  for (var command in commands) {
    command.forEach((key, value) {
      switch (key) {
        case 'forward':
          horizontalPosition += value;
          depth += value * aim;
          break;
        case 'up':
          aim -= value;
          break;
        case 'down':
          aim += value;
          break;
      }
    });
  }
  print(
      'depth: $depth, hp: $horizontalPosition, multiplied: ${depth * horizontalPosition}');
}

List<Map<String, int>> parseCommands(List<String> commandsData) {
  final commands = commandsData.map((e) {
    final commandData = e.split(' ');
    return {commandData[0]: int.parse(commandData[1])};
  }).toList();

  return commands;
}
