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
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          axis: Axis.horizontal,
          value: _currentValue,
          minValue: 0,
          maxValue: 40,
          onChanged: (value) => setState(() => _currentValue = value),
        ),
        Divider(),
        FloatingActionButton(
          onPressed: () => widget.kid.points += _currentValue,
          tooltip: 'Add Points',
          child: Icon(Icons.check),
        ),
      ],
    );
  }
}
