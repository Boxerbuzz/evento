import 'package:flutter/material.dart';

class EvRadioInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final List<String> options;
  final String? selected;
  final BoxShape shape;
  final TextStyle? style;
  final Axis? direction;

  const EvRadioInput(
      {this.onChanged,
      this.options = const ['foo', 'bar'],
      this.selected,
      this.shape = BoxShape.rectangle,
      this.style,
      this.direction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      descendantsAreFocusable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            direction: direction ?? Axis.horizontal,
            children: options.map((option) {
              return InkWell(
                onTap: () => onChanged!(option),
                child: Container(
                  margin: const EdgeInsets.only(right: 16, bottom: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 2,
                            color: const Color(0xff292929),
                          ),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: shape,
                            color: selected == option
                                ? Theme.of(context).colorScheme.primary
                                : null,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        option,
                        style: style ?? Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
