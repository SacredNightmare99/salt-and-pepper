import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

const double kBorder = 2.5;

const Color bg = Color(0xFFFFF3E6);
const Color black = Colors.black;
const Color red = Color(0xFFFF4D2D);
const Color yellow = Color(0xFFFFC700);
const Color green = Color(0xFFB6E3B6);
const Color white = Colors.white;

/// JSON schema for StepCard
final _stepCardSchema = S.object(
  description: 'Card displaying a recipe step',
  properties: {
    'stepNumber': S.integer(description: 'Step number (1, 2, 3...)'),
    'instruction': S.string(description: 'Detailed explanation of the step'),
    'tip': S.string(description: 'Optional tip or point of attention'),
    'duration': S.string(description: 'Estimated duration of this step'),
  },
  required: ['stepNumber', 'instruction'],
);

/// StepCard CatalogItem definition
final stepCardItem = CatalogItem(
  name: 'StepCard',
  dataSchema: _stepCardSchema,
  widgetBuilder: (itemContext) {
    final json = itemContext.data as Map<String, Object?>;
    final stepNumber = (json['stepNumber'] as num?)?.toInt() ?? 1;
    final instruction = json['instruction'] as String? ?? '';
    final tip = json['tip'] as String?;
    final duration = json['duration'] as String?;

    return _StepCardWidget(
      stepNumber: stepNumber,
      instruction: instruction,
      tip: tip,
      duration: duration,
    );
  },
);

class _StepCardWidget extends StatefulWidget {
  final int stepNumber;
  final String instruction;
  final String? tip;
  final String? duration;

  const _StepCardWidget({
    required this.stepNumber,
    required this.instruction,
    this.tip,
    this.duration,
  });

  @override
  State<_StepCardWidget> createState() => _StepCardWidgetState();
}

class _StepCardWidgetState extends State<_StepCardWidget> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: _isCompleted ? green : white,
        border: Border.all(color: black, width: kBorder),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _isCompleted = !_isCompleted;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER ROW
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _isCompleted ? black : red,
                      border: Border.all(color: black, width: kBorder),
                    ),
                    child: Center(
                      child: _isCompleted
                          ? const Icon(Icons.check, color: white, size: 20)
                          : Text(
                              '${widget.stepNumber}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'STEP ${widget.stepNumber}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  if (widget.duration != null) ...[
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: yellow,
                        border: Border.all(color: black, width: kBorder),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            widget.duration!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 12),

              // INSTRUCTION
              Text(
                widget.instruction.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  decoration:
                      _isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),

              // TIP
              if (widget.tip != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: yellow,
                    border: Border.all(color: black, width: kBorder),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.tip!.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
