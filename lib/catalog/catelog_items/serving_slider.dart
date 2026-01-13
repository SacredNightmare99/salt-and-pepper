import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

const double kBorder = 2.5;

const Color bg = Color(0xFFFFF3E6);
const Color black = Colors.black;
const Color red = Color(0xFFFF4D2D);
const Color yellow = Color(0xFFFFC700);
const Color white = Colors.white;

/// JSON schema for ServingSlider
final _servingSliderSchema = S.object(
  description: 'Slider used to adjust the number of servings',
  properties: {
    'minServings': S.integer(description: 'Minimum number of servings'),
    'maxServings': S.integer(description: 'Maximum number of servings'),
    'defaultServings': S.integer(description: 'Default number of servings'),
    'label': S.string(description: 'Slider label'),
  },
  required: ['defaultServings'],
);

/// ServingSlider CatalogItem definition
final servingSliderItem = CatalogItem(
  name: 'ServingSlider',
  dataSchema: _servingSliderSchema,
  widgetBuilder: (itemContext) {
    final json = itemContext.data as Map<String, Object?>;
    final minServings = (json['minServings'] as num?)?.toInt() ?? 1;
    final maxServings = (json['maxServings'] as num?)?.toInt() ?? 8;
    final defaultServings = (json['defaultServings'] as num?)?.toInt() ?? 4;
    final label = json['label'] as String? ?? 'SERVINGS';

    return _ServingSliderWidget(
      minServings: minServings,
      maxServings: maxServings,
      defaultServings: defaultServings,
      label: label,
      dispatchEvent: itemContext.dispatchEvent,
      id: itemContext.id,
    );
  },
);

class _ServingSliderWidget extends StatefulWidget {
  final int minServings;
  final int maxServings;
  final int defaultServings;
  final String label;
  final void Function(UiEvent event) dispatchEvent;
  final String id;

  const _ServingSliderWidget({
    required this.minServings,
    required this.maxServings,
    required this.defaultServings,
    required this.label,
    required this.dispatchEvent,
    required this.id,
  });

  @override
  State<_ServingSliderWidget> createState() => _ServingSliderWidgetState();
}

class _ServingSliderWidgetState extends State<_ServingSliderWidget> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.defaultServings.toDouble();
  }

  void _onChanged(double value) {
    setState(() {
      _currentValue = value;
    });

    widget.dispatchEvent(
      UserActionEvent(
        name: 'servingChanged',
        sourceComponentId: widget.id,
        context: {'servings': value.round()},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final servings = _currentValue.round();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: black, width: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: red,
                  border: Border.all(color: black, width: kBorder),
                ),
                child: const Icon(Icons.people, color: white, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                widget.label.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: yellow,
                  border: Border.all(color: black, width: kBorder),
                ),
                child: Text(
                  '$servings',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // SLIDER (same logic, flat look)
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: black,
              inactiveTrackColor: black.withOpacity(0.2),
              thumbColor: red,
              overlayColor: Colors.transparent,
              trackHeight: 6,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: _currentValue,
              min: widget.minServings.toDouble(),
              max: widget.maxServings.toDouble(),
              divisions: widget.maxServings - widget.minServings,
              onChanged: _onChanged,
            ),
          ),

          // MIN / MAX
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.minServings}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${widget.maxServings}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
