import 'package:flutter/material.dart';
import 'package:kid_good_good/kid/history/history.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../kid.dart';

class PointSelector extends StatefulWidget {
  const PointSelector({
    Key? key,
    required this.initialValue,
    required this.kid,
    required this.kidRepository,
    this.initialDateTime,
    this.historyUpdates = const [],
  }) : super(key: key);

  final int initialValue;
  final KidRepository kidRepository;
  final Kid kid;

  final DateTime? initialDateTime;

  /// Can also update historical values as well, but won't change their [DateTime]
  final List<PointHistory> historyUpdates;

  @override
  _PointSelectorState createState() => _PointSelectorState();
}

class _PointSelectorState extends State<PointSelector> {
  late int _currentValue;
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _selectedDate = widget.initialDateTime;
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
                color: Theme.of(context).colorScheme.surface,
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
        if (widget.historyUpdates.length <= 1)
          SizedBox(
            width: 300,
            height: 300,
            child: SfDateRangePicker(
              initialSelectedDate: _selectedDate,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                _selectedDate = args.value as DateTime;
                debugPrint("new selectedDate: $_selectedDate");
              },
              selectionMode: DateRangePickerSelectionMode.single,
              showTodayButton: true,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(const Duration(days: 4)),
                  DateTime.now().add(const Duration(days: 3))),
            ),
          ),
        SizedBox(height: 12),
        FloatingActionButton.small(
          onPressed: () {
            final selectedDateTime = _selectedDate;
            if (selectedDateTime != null) {
              widget.kidRepository.addPoints(
                  id: widget.kid.id,
                  points: _currentValue,
                  dateTime: selectedDateTime);
            } else if (widget.historyUpdates.isEmpty) {
              widget.kidRepository
                  .addPoints(id: widget.kid.id, points: _currentValue);
            }

            widget.historyUpdates.forEach((pointHistory) {
              if (pointHistory is MissingPointHistory) {
                // MissingPointHistory is just a Visual queue, doesn't exist in history so just add it
                widget.kidRepository.addPoints(
                    id: widget.kid.id,
                    points: _currentValue,
                    dateTime: pointHistory.dateTime);
              } else {
                widget.kidRepository.updatePoints(
                    id: widget.kid.id,
                    pointHistoryItem: pointHistory,
                    newPoints: _currentValue);
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
