import 'package:flutter/material.dart';

class SizeInput extends StatefulWidget {
  final String size;
  final String text;
  final Function(int) onChanged;

  const SizeInput({
    super.key,
    required this.text,
    required this.size,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SizeInputState createState() => _SizeInputState();
}

class _SizeInputState extends State<SizeInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(widget.size),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(),
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.onChanged(int.tryParse(value) ?? 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}