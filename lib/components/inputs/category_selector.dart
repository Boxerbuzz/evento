import 'package:flutter/material.dart';

class EvCategorySelector extends StatefulWidget {
  const EvCategorySelector(
      {this.options = const [], required this.label, this.onChanged, Key? key})
      : super(key: key);
  final List<String>? options;
  final String label;
  final ValueChanged<String>? onChanged;

  @override
  _EvCategorySelectorState createState() => _EvCategorySelectorState();
}

class _EvCategorySelectorState extends State<EvCategorySelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: [],
      onChanged: (value) {},
    );
  }
}
