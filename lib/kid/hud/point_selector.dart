import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../kid.dart';

class PointSelector extends StatefulWidget {
  const PointSelector({
    Key? key,
    required this.initialValue,
    required this.kid,
  }) : super(key: key);

  final int initialValue;
  final Kid kid;

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
                    axis: Axis.horizontal,
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
        Divider(),
        FloatingActionButton.small(
          onPressed: () => widget.kid.points += _currentValue,
          tooltip: 'Add Points',
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
