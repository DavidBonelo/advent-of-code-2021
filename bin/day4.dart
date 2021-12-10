import 'dart:io';

void main() {
  // final File file = File('data/day4input.txt');
  final File file = File('data/day4input_example.txt');
  final List<String> report = file.readAsLinesSync();
  // for (var line in report) {
  //   print(line);
  // }
  print(getWinnerBoard(report));
}

Map getWinnerBoard(List<String> report) {
  final List<String> numbersToDraw = report[0].split(',');
  print('numbersToDraw: $numbersToDraw');

  final boards = getBoards(report);
  final List<List<List<String>>> boardsMatrix = [];
  for (var board in boards) {
    boardsMatrix.add(getBoardMatrix(board));
  }
  final playableBoardsMatrix = boardsMatrix.toList();

  Map lastWinner = {'winnerBoard': null};

  for (var number in numbersToDraw) {
    final result = playNumber(playableBoardsMatrix, number);
    if (result['win'] == true) {
      // if objectivo = win
      // return result;
      // return result..addAll({'originalBoard': boardsMatrix[result['boardIndex']]});

      // if objectivo = lose
      lastWinner = result;
      print(result);
      playableBoardsMatrix.removeAt(result['boardIndex']);
    }
  }
  return lastWinner;
}

Map playNumber(List<List<List<String>>> boardsMatrix, String number) {
  Map winner = {'win': false};
  for (var i = 0; i < boardsMatrix.length; i++) {
    final board = boardsMatrix[i];

    if (drawNumber(board, number)) {
      // return {
      winner = {
        'win': true,
        'finalBoard': board,
        'boardIndex': i,
        'score': calculateScore(board, number),
        'calledNumber': number,
      };
    }
  }
  return winner;
}

enum Objective { win, lose }

int calculateScore(List<List<String>> board, String number) {
  int unmarkedNumsSum = 0;
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 5; j++) {
      if (board[i][j] != 'X') {
        unmarkedNumsSum += int.parse(board[i][j]);
      }
    }
  }
  // print('uSum: $unmarkedNumsSum');
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
        return checkWin(board, j);
      }
    }
  }
  return false;
}

/// count X in column and row
bool checkWin(List<List<String>> board, int colIndex) {
  int xCountx = 0, xCounty = 0;
  for (var i = 0; i < 5; i++) {
    if (board[colIndex][i] == 'X') xCountx++;
    if (board[i][colIndex] == 'X') xCounty++;
  }
  if (xCountx == 5) return true;
  if (xCounty == 5) return true;
  return false;
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

List<List<String>> getBoardMatrix(List<String> board) {
  final List<List<String>> boardMatrix = [];
  // initialize boardColumns inner Lists
  // contains [col1, col2, col3, col4, col5] cols are also lists
  for (var i = 0; i < 5; i++) {
    boardMatrix.add([]);
  }

  // fills every col
  for (var row in board) {
    final rowNumbers = row.split(' ')
      ..removeWhere((element) => element.isEmpty);
    // bingo has 5 columns
    for (var i = 0; i < 5; i++) {
      boardMatrix[i].add(rowNumbers[i]);
    }
  }
  return boardMatrix;
}
