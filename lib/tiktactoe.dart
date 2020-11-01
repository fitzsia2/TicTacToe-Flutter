import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  TicTacToe({Key key}) : super(key: key);

  @override
  State createState() => _TicTacToeState();
}

enum _Player { x, o }

extension _PlayerExtension on _Player {
  _TicTacToeCellState toCellState() {
    if (this == _Player.x)
      return _TicTacToeCellState.x;
    else
      return _TicTacToeCellState.o;
  }

  String stringify() {
    switch (this) {
      case _Player.x:
        return 'X';
        break;
      case _Player.o:
        return 'O';
        break;
    }
    return '';
  }
}

class _BoardState {
  _BoardState._internal(this.state);

  final List<List<_TicTacToeCellState>> state;

  factory _BoardState() {
    return _BoardState._internal([
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ]);
  }

  factory _BoardState.from(_BoardState boardState) {
    final List<_TicTacToeCellState> row1 = List.from(boardState.state[0]);
    final List<_TicTacToeCellState> row2 = List.from(boardState.state[1]);
    final List<_TicTacToeCellState> row3 = List.from(boardState.state[2]);
    return _BoardState._internal([row1, row2, row3]);
  }

  List<_TicTacToeCellState> row(int col) => state[col];
}

class _TicTacToeState extends State<TicTacToe> {
  int _move = 0;
  List<_BoardState> _history = List.filled(1, _BoardState(), growable: true);
  _Player _player = _Player.x;

  void onCellPressed(int row, int col) {
    setState(() {
      var boardState = _BoardState.from(_history[_move]);
      boardState.state[row][col] = _player.toCellState();
      _changePlayer();
      _history.add(boardState);
      _move++;
    });
  }

  void _changePlayer() {
    switch (_player) {
      case _Player.x:
        _player = _Player.o;
        break;
      case _Player.o:
        _player = _Player.x;
        break;
    }
  }

  void _onResetPressed() {
    setState(() {
      _player = _Player.x;
      _move = 0;
      _history = List.filled(1, _BoardState(), growable: true);
    });
  }

  void _onUndoPressed() {
    setState(() {
      if (_move > 0) {
        _changePlayer();
        _history.removeLast();
        _move--;
      } else {
        _player = _Player.x;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _BoardState boardState = _history[_move];
    return Column(
      children: [
        Text(
          'Next player: ${_player.stringify()}',
          style: Theme.of(context).textTheme.headline4,
        ),
        Table(
          defaultColumnWidth: FixedColumnWidth(80.0),
          children: [
            TableRow(children: _makeRow(onCellPressed, 0, boardState.row(0))),
            TableRow(children: _makeRow(onCellPressed, 1, boardState.row(1))),
            TableRow(children: _makeRow(onCellPressed, 2, boardState.row(2))),
          ],
        ),
        Row(mainAxisSize: MainAxisSize.min, children: [
          ElevatedButton(onPressed: _onResetPressed, child: Text('Reset')),
          SizedBox(width: 16.0),
          ElevatedButton(onPressed: _onUndoPressed, child: Text('Undo')),
        ]),
      ],
    );
  }

  List<TicTacToeCell> _makeRow(TicTacToeCellCallback callback, int row,
      List<_TicTacToeCellState> rowStates) {
    return [
      TicTacToeCell(
        onPressed: onCellPressed,
        row: row,
        col: 0,
        state: rowStates[0],
      ),
      TicTacToeCell(
        onPressed: onCellPressed,
        row: row,
        col: 1,
        state: rowStates[1],
      ),
      TicTacToeCell(
        onPressed: onCellPressed,
        row: row,
        col: 2,
        state: rowStates[2],
      ),
    ];
  }
}

typedef TicTacToeCellCallback = void Function(int row, int col);

class TicTacToeCell extends StatelessWidget {
  TicTacToeCell({Key key, this.onPressed, this.row, this.col, this.state})
      : super(key: key);

  final TicTacToeCellCallback onPressed;
  final int row;
  final int col;
  final _TicTacToeCellState state;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => {if (state == null) onPressed(row, col) else null},
          child: _makeCellStateWidget(state),
        ));
  }

  Widget _makeCellStateWidget(_TicTacToeCellState state) {
    switch (state) {
      case _TicTacToeCellState.x:
        return Text('X');
        break;
      case _TicTacToeCellState.o:
        return Text('O');
        break;
      default:
        return null;
    }
  }
}

enum _TicTacToeCellState { x, o }
