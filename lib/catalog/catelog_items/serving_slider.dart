import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

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
    final label = json['label'] as String? ?? 'Servings';

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

/// ServingSlider StatefulWidget
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

    // Notify DataModel (AI will observe this change)
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
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header and value
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.label,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // Servings indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$servings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'people',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Theme.of(context).colorScheme.primary,
                  inactiveTrackColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  thumbColor: Theme.of(context).colorScheme.primary,
                  overlayColor: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.2),
                  trackHeight: 8,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 14,
                  ),
                ),
                child: Slider(
                  value: _currentValue,
                  min: widget.minServings.toDouble(),
                  max: widget.maxServings.toDouble(),
                  divisions: widget.maxServings - widget.minServings,
                  onChanged: _onChanged,
                ),
              ),

              // Min–max labels
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.minServings} people',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    Text(
                      '${widget.maxServings} people',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
