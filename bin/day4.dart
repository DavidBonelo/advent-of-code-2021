import 'dart:io';

void main() {
  final File file = File('data/day4input.txt');
  // final File file = File('data/day4input_example.txt');
  final List<String> report = file.readAsLinesSync();
  print(getWinnerBoard(report, Position.first));
  print(getWinnerBoard(report, Position.last));
}

Map getWinnerBoard(List<String> report, Position position) {
  final List<String> numbersToDraw = report[0].split(',');
  print('numbersToDraw: $numbersToDraw');

  final boardsDataList = getBoardsData(report);
  final List<List<List<String>>> boardsList = [];
  for (var boardData in boardsDataList) {
    boardsList.add(getBoardMatrix(boardData));
  }

  Map lastWinner = {};

  for (var number in numbersToDraw) {
    final winners = playNumber(boardsList, number);
    if (winners.isNotEmpty) {
      if (position == Position.first) return winners.first;

      // if position == last
      lastWinner = winners.last;

      int removedCounter = 0;
      for (var winner in winners) {
        final int winnerIndex = winner['boardIndex'] - removedCounter;
        boardsList.removeAt(winnerIndex);
        removedCounter++;
      }
    }
  }
  return lastWinner;
}

enum Position { first, last }

List<Map> playNumber(List<List<List<String>>> boardsMatrix, String number) {
  List<Map> winners = [];

  for (var i = 0; i < boardsMatrix.length; i++) {
    final board = boardsMatrix[i];

    if (drawNumber(board, number)) {
      winners.add({
        'finalBoard': board,
        'boardIndex': i,
        'score': calculateScore(board, number),
        'calledNumber': number,
      });
    }
  }
  return winners;
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
  print('uSum: $unmarkedNumsSum');
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

List<List<String>> getBoardsData(List<String> report) {
  final List<List<String>> boards = [];
  for (var i = 2; i < report.length - 5; i += 6) {
    boards.add(
      [report[i], report[i + 1], report[i + 2], report[i + 3], report[i + 4]],
    );
  }
  return boards;
}

List<List<String>> getBoardMatrix(List<String> board) {
  final List<List<String>> boardMatrix = [];
  for (var i = 0; i < 5; i++) {
    final rowNumbers = board[i].split(' ')
      ..removeWhere((element) => element.isEmpty);
    boardMatrix.add(rowNumbers);
  }
  return boardMatrix;
}
