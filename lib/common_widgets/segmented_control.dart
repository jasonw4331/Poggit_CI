import 'package:flutter/cupertino.dart';

class SegmentedControl<T> extends StatelessWidget {
  const SegmentedControl({
    required this.header,
    required this.value,
    required this.children,
    required this.onValueChanged,
  });
  final Widget header;
  final Object value;
  final Map<Object, Widget> children;
  final ValueChanged onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: header,
        ),
        SizedBox(
          width: double.infinity,
          child: CupertinoSegmentedControl<Object>(
            children: children,
            groupValue: value,
            onValueChanged: onValueChanged,
          ),
        ),
      ],
    );
  }
}
