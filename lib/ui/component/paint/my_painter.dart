import 'package:flutter/material.dart';
 
class BoardPainter extends CustomPainter {
  final List<Offset> blackPieces;
  final List<Offset> whitePieces;
  final double cellSize;
  final int boardSize;
 
  BoardPainter({
    required this.blackPieces,
    required this.whitePieces,
    required this.cellSize,
    required this.boardSize,
  });
 
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;
    final blackPaint = Paint()..color = Colors.black;
    final radius = cellSize / 2 - 2.0; // 减去一些边框宽度以避免重叠
 
    // 绘制网格线
    for (int i = 0; i <= boardSize; i++) {
      canvas.drawLine(Offset(i * cellSize, 0), Offset(i * cellSize, boardSize * cellSize), paint);
      canvas.drawLine(Offset(0, i * cellSize), Offset(boardSize * cellSize, i * cellSize), paint);
    }
 
    // 绘制黑子和白子
    for (var offset in blackPieces) {
      canvas.drawCircle(offset, radius, blackPaint);
    }
    for (var offset in whitePieces) {
      canvas.drawCircle(offset, radius, whitePaint);
    }
  }
 
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // 当数据改变时重绘整个棋盘，实际应用中可以根据需要优化此方法。
  }
}