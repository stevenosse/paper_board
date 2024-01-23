import 'package:flutter/material.dart';

class SizeSelectorWidget extends StatefulWidget {
  const SizeSelectorWidget({
    super.key,
    this.initialSize = 1.0,
    this.onSizeChanged,
  });

  final double initialSize;
  final ValueChanged<double>? onSizeChanged;

  @override
  State<SizeSelectorWidget> createState() => _SizeSelectorWidgetState();
}

class _SizeSelectorWidgetState extends State<SizeSelectorWidget> {
  late double _size = widget.initialSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: Card(
        shape: const StadiumBorder(),
        child: Slider(
          value: _size,
          min: 1.0,
          max: 10.0,
          onChanged: (value) =>
              setState(() => _size = value.round().toDouble()),
          onChangeEnd: (value) =>
              widget.onSizeChanged?.call(value.round().toDouble()),
        ),
      ),
    );
  }
}
