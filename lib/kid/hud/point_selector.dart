import 'package:flutter/material.dart';
import 'package:kid_good_good/kid/history/history.dart';
import 'package:numberpicker/numberpicker.dart';

import '../kid.dart';

class PointSelector extends StatefulWidget {
  const PointSelector({
    Key? key,
    required this.initialValue,
    required this.kid,
    this.dateTime,
    this.historyUpdates = const [],
  }) : super(key: key);

  final int initialValue;
  final Kid kid;

  final DateTime? dateTime;

  /// Can also update historical values as well, but won't change their [DateTime]
  final List<PointHistory> historyUpdates;

  @override
  _PointSelectorState createState() => _PointSelectorState();
}

class _PointSelectorState extends State<PointSelector> {
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 3.5,
                color: Colors.blueGrey[100],
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: NumberPicker(
                    axis: Axis.vertical,
                    value: _currentValue,
                    minValue: 0,
                    maxValue: 40,
                    onChanged: (value) => setState(() => _currentValue = value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        FloatingActionButton.small(
          onPressed: () {
            final dateTime = widget.dateTime;
            if (dateTime != null) {
              widget.kid.addPointsAtTime(_currentValue, dateTime);
            }
            // Silly side affect for now, assuming if you are doing history, don't assume to give current day as well
            else if (widget.historyUpdates.isEmpty) {
              widget.kid.points += _currentValue;
            }

            widget.historyUpdates.forEach((pointHistory) {
              if (pointHistory is MissingPointHistory) {
                // MissingPointHistory is just a Visual queue, doesn't exist in history so just add it
                widget.kid
                    .addPointsAtTime(_currentValue, pointHistory.dateTime);
              } else {
                widget.kid.updatePoints(pointHistory, _currentValue);
              }
            });
          },
          tooltip: 'Add Points',
          child: Icon(Icons.check),
        ),
      ],
    );
  }
}
