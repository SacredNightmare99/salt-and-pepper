import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

const double kBorder = 2.5;

const Color black = Colors.black;
const Color red = Color(0xFFFF4D2D);
const Color yellow = Color(0xFFFFC700);
const Color green = Color(0xFFB6E3B6);
const Color white = Colors.white;

/// JSON schema for IngredientList
final _ingredientListSchema = S.object(
  description: 'List of recipe ingredients',
  properties: {
    'ingredients': S.list(
      description: 'Ingredient list',
      items: S.object(
        properties: {
          'name': S.string(description: 'Ingredient name (e.g. chicken thigh)'),
          'amount': S.string(description: 'Amount (e.g. 500)'),
          'unit': S.string(description: 'Unit (e.g. grams, pieces, cups)'),
        },
        required: ['name', 'amount', 'unit'],
      ),
    ),
    'servings': S.integer(description: 'Number of servings'),
  },
  required: ['ingredients'],
);

/// IngredientList CatalogItem definition
final ingredientListItem = CatalogItem(
  name: 'IngredientList',
  dataSchema: _ingredientListSchema,
  widgetBuilder: (itemContext) {
    final json = itemContext.data as Map<String, Object?>;
    final ingredientsData = json['ingredients'] as List<Object?>? ?? [];
    final servings = (json['servings'] as num?)?.toInt() ?? 4;

    final ingredients = ingredientsData.map((item) {
      final map = item as Map<String, Object?>;
      return _Ingredient(
        name: map['name'] as String? ?? '',
        amount: map['amount'] as String? ?? '',
        unit: map['unit'] as String? ?? '',
      );
    }).toList();

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
                child: const Icon(
                  Icons.shopping_basket,
                  color: white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'INGREDIENTS',
                style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: yellow,
                  border: Border.all(color: black, width: kBorder),
                ),
                child: Text(
                  '$servings SERVINGS',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // LIST
          ...ingredients.map(
            (ingredient) => _IngredientRow(ingredient: ingredient),
          ),
        ],
      ),
    );
  },
);

/// Ingredient model
class _Ingredient {
  final String name;
  final String amount;
  final String unit;

  const _Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
  });
}

/// Single ingredient row
class _IngredientRow extends StatefulWidget {
  final _Ingredient ingredient;

  const _IngredientRow({required this.ingredient});

  @override
  State<_IngredientRow> createState() => _IngredientRowState();
}

class _IngredientRowState extends State<_IngredientRow> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _isChecked ? green : white,
          border: Border.all(color: black, width: kBorder),
        ),
        child: Row(
          children: [
            // CHECKBOX
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _isChecked ? black : white,
                border: Border.all(color: black, width: kBorder),
              ),
              child: _isChecked
                  ? const Icon(Icons.check, size: 16, color: white)
                  : null,
            ),
            const SizedBox(width: 12),

            // NAME
            Expanded(
              child: Text(
                widget.ingredient.name.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  decoration: _isChecked ? TextDecoration.lineThrough : null,
                ),
              ),
            ),

            // AMOUNT
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: yellow,
                border: Border.all(color: black, width: kBorder),
              ),
              child: Text(
                '${widget.ingredient.amount} ${widget.ingredient.unit}'
                    .toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
