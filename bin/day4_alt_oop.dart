import 'dart:io';

void main() {
  final File file = File('data/day4input.txt');
  // final File file = File('data/day4input_example.txt');
  final List<String> report = file.readAsLinesSync();
  print(getWinnerBoard(report, Position.first));
  print(getWinnerBoard(report, Position.last));
}

Board? getWinnerBoard(List<String> report, Position position) {
  final List<String> numbersToDraw = report[0].split(',');
  print('numbersToDraw: $numbersToDraw');

  final boardsDataList = getBoards(report);
  final List<Board> boardsList = [];
  for (var boardData in boardsDataList) {
    boardsList.add(Board.fromRowsList(boardData));
  }

  Board? lastWinner;

  for (var number in numbersToDraw) {
    final winners = playNumber(boardsList, number);
    if (winners.isNotEmpty) {
      if (position == Position.first) return boardsList[winners.first];

      // if position == last
      lastWinner = boardsList[winners.last];

      int removedCounter = 0;
      for (var winner in winners) {
        final winnerIndex = winner - removedCounter;
        boardsList.removeAt(winnerIndex);
        removedCounter++;
      }
    }
  }
  return lastWinner;
}

enum Position { first, last }

List<int> playNumber(List<Board> boardsList, String number) {
  List<int> winners = [];

  for (var i = 0; i < boardsList.length; i++) {
    final board = boardsList[i];
    if (board.drawNumber(number)) {
      winners.add(i);
    }
  }
  return winners;
}

List<List<String>> getBoards(List<String> report) {
  final List<List<String>> boards = [];
  for (var i = 2; i < report.length - 5; i += 6) {
    boards.add(
      [report[i], report[i + 1], report[i + 2], report[i + 3], report[i + 4]],
    );
  }
  return boards;
}

class Board {
  final List<List<String>> _boardMatrix = [];
  int _unmarkedNumsSum = 0;
  String? _lastDrawnNumber;
  int? _score;

  Board.fromRowsList(List<String> boardRows) {
    for (var i = 0; i < 5; i++) {
      final rowNumbers = boardRows[i].split(' ')
        ..removeWhere((element) => element.isEmpty);
      _boardMatrix.add(rowNumbers);
    }
  }

  /// draws a number from the board and returns true if the board wins!!
  bool drawNumber(String number) {
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        if (_boardMatrix[i][j] == number) {
          // replace value with an X
          _boardMatrix[i][j] = 'X';
          // When the number is found, check if the board is a winner
          if (_checkWin(j, i)) {
            _lastDrawnNumber = number;
            _calculateScore(number);
            return true;
          } else {
            return false;
          }
        }
      }
    }
    return false;
  }

  /// counts X in column and row
  bool _checkWin(int xIndex, int yIndex) {
    int xCountx = 0, xCounty = 0;
    for (var i = 0; i < 5; i++) {
      if (_boardMatrix[yIndex][i] == 'X') xCountx++;
      if (_boardMatrix[i][xIndex] == 'X') xCounty++;
    }
    if (xCountx == 5 || xCounty == 5) return true;
    return false;
  }

  void _calculateScore(String number) {
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        if (_boardMatrix[i][j] != 'X') {
          _unmarkedNumsSum += int.parse(_boardMatrix[i][j]);
        }
      }
    }
    _score = _unmarkedNumsSum * int.parse(number);
  }

  @override
  String toString() {
    return '''
board:
${_boardMatrix[0]}\n${_boardMatrix[1]}\n${_boardMatrix[2]}\n${_boardMatrix[3]}\n${_boardMatrix[4]}
lastDrawnNumber: $_lastDrawnNumber
unmarkedNumsSum: $_unmarkedNumsSum
score: $_score\n''';
  }
}
