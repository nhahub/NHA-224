import 'package:flutter/material.dart';

class ReportWidget extends StatefulWidget {
  final Function(Map<String, bool>) onChanged;

  const ReportWidget({required this.onChanged, Key? key}) : super(key: key);

  @override
  _ReportWidgetState createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  Map<String, bool> reportOptions = {
    "Abusive or offensive language": false,
    "Hate speech": false,
    "Spam or promotion": false,
    "Fake or misleading review": false,
    "Irrelevant content": false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: reportOptions.keys.map((key) {
        return CheckboxListTile(
          title: Text(key),
          value: reportOptions[key],
          onChanged: (value) {
            setState(() {
              reportOptions[key] = value ?? false;
            });

            // Notify parent
            widget.onChanged(reportOptions);
          },
        );
      }).toList(),
    );
  }
}
