// * this version is based on the score for every board,
// ! but aparently in this "USA Bingo" the worse score doesn't necesarly means it is the last board to win, so GG :clown:

import 'dart:io';

void main() {
  final File file = File('data/day4input.txt');
  // final File file = File('data/day4input_example.txt');
  final List<String> report = file.readAsLinesSync();

  final List<String> numbersToDraw = report[0].split(',');

  int bestScoreBoard = 0;
  int worseScoreBoard = 0;

  for (var i = 2; i < report.length - 5; i += 6) {
    // builds the board
    final List<List<String>> board = [];
    for (var j = 0; j < 5; j++) {
      final rowNumbers = report[i + j].split(' ')
        ..removeWhere((element) => element.isEmpty);
      board.add(rowNumbers);
    }

    for (final number in numbersToDraw) {
      if (drawNumber(board, number)) {
        final score = calculateScore(board, number);
        bestScoreBoard = (score > bestScoreBoard) ? score : bestScoreBoard;
        worseScoreBoard = (i == 2) // 2 is the initial value of i here
            ? score
            : (score < worseScoreBoard && score != 0)
                ? score
                : worseScoreBoard;
        break;
      }
    }
  }
  print('bestScoreBoard: $bestScoreBoard \nworseScoreBoard: $worseScoreBoard');
}

int calculateScore(List<List<String>> board, String number) {
  int unmarkedNumsSum = 0;
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 5; j++) {
      if (board[i][j] != 'X') {
        unmarkedNumsSum += int.parse(board[i][j]);
      }
    }
  }
  return unmarkedNumsSum * int.parse(number);
}

/// draws a number from the board and returns true if the board wins!!
bool drawNumber(List<List<String>> board, String number) {
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 5; j++) {
      if (board[i][j] == number) {
        // replace value with an X
        board[i][j] = 'X';
        // When the number is found, check if the board is a winner
        return checkWin(board, j, i);
      }
    }
  }
  return false;
}

/// counts X in column and row
bool checkWin(List<List<String>> board, int xIndex, int yIndex) {
  int xCountx = 0, xCounty = 0;
  for (var i = 0; i < 5; i++) {
    if (board[yIndex][i] == 'X') xCountx++;
    if (board[i][xIndex] == 'X') xCounty++;
  }
  if (xCountx == 5) return true;
  if (xCounty == 5) return true;
  return false;
}
