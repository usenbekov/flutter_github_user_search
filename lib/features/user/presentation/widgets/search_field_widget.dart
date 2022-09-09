import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  final void Function(String value) onInputChanged;
  const SearchFieldWidget({Key? key, required this.onInputChanged})
      : super(key: key);

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Search by username',
        suffixIcon: Icon(Icons.search),
      ),
      onChanged: (val) {
        widget.onInputChanged(val);
      },
    );
  }
}
