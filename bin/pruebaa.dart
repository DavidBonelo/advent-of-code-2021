// void main(List<String> args) {
//   final xd = ' 6 10  3 18  5';
//   print(xd.split(' '));
//   print(xd.split(' ')..removeWhere((element) => element.isEmpty));
//   print(xd.split(' ').where((element) => element.isNotEmpty).toList());
// }
// void main() {
//   var originalMatrix = [[1],[2],[3]];
//   final matrixCopy = originalMatrix.toList();
//   matrixCopy[0][0] = 69;
//   print(originalMatrix); // [[69], [2], [3]]
//   print(matrixCopy); // [[69], [2], [3]]
// }
// void main() {
//   var originalMatrix = [
//     XD([1]),
//     XD([2]),
//     XD([3])
//   ];
//   final matrixCopy = originalMatrix.toList();
//   matrixCopy[0].a[0] = 69;
//   print(originalMatrix); // [[69], [2], [3]]
//   print(matrixCopy); // [[69], [2], [3]]
// }

// class XD {
//   List<int> a;
//   XD(this.a);

//   @override
//   String toString() {
//     return a.toString();
//   }
// }

void main(List<String> args) {
  final a = [
    ['X', 'X', 'X', 'a', 'X'],
    ['34', ' X', ' 45', ' 20', 'X'],
    ['55', ' 94', 'X', ' 43', 'a'],
    ['X', 'X', 'X', 'X', 'X'],
    ['64', ' 91', ' 63', ' X', 'X']
  ];
  var b = checkWin(a, 0, 3);
  print(b);
}

bool checkWin(List<List<String>> board, int xIndex, int yIndex) {
  int xCountx = 0, xCounty = 0;
  for (var i = 0; i < 5; i++) {
    // print('col: x$xIndex y$i \nrow: x$i y$yIndex');
    print('col: ${board[i][yIndex]}');
    print('row: ${board[yIndex][i]}');
    if (board[yIndex][i] == 'X') xCountx++;
    if (board[i][yIndex] == 'X') xCounty++;
  }
  print(xCountx);
  print(xCounty);
  if (xCountx == 5) return true;
  if (xCounty == 5) return true;
  return false;
}
