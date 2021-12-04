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
  final List<Command> commands = parseCommands(commandsData);

  calculatePosition(commands);
  calculatePositionButAfterReadingTheManualLMAO(commands);
}

void calculatePosition(List<Command> commands) {
  int depth = 0;
  int horizontalPosition = 0;

  for (var command in commands) {
    switch (command.instruction) {
      case 'forward':
        horizontalPosition += command.value;
        break;
      case 'up':
        depth -= command.value;
        break;
      case 'down':
        depth += command.value;
        break;
    }
  }

  print(
      'depth: $depth, hp: $horizontalPosition, multiplied: ${depth * horizontalPosition}');
}

void calculatePositionButAfterReadingTheManualLMAO(List<Command> commands) {
  int depth = 0;
  int horizontalPosition = 0;
  int aim = 0;

  for (var command in commands) {
    switch (command.instruction) {
      case 'forward':
        horizontalPosition += command.value;
        depth += command.value * aim;
        break;
      case 'up':
        aim -= command.value;
        break;
      case 'down':
        aim += command.value;
        break;
    }
  }
  print(
      'depth: $depth, hp: $horizontalPosition, multiplied: ${depth * horizontalPosition}');
}

List<Command> parseCommands(List<String> commandsData) {
  final commands = commandsData.map((e) {
    final commandData = e.split(' ');
    return Command(commandData[0], int.parse(commandData[1]));
  }).toList();

  return commands;
}

class Command {
  final String instruction;
  final int value;
  Command(this.instruction, this.value);
}
