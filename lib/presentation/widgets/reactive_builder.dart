import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReactiveBuilder<T> extends StatelessWidget {
  final ValueListenable<T> value;
  final Widget Function(T) builder;

  const ReactiveBuilder({
    super.key,
    required this.value,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (_, value, __) {
        return builder(value);
      },
    );
  }
}
