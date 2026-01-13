import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

const double kBorder = 2.5;

const Color black = Colors.black;
const Color red = Color(0xFFFF4D2D);
const Color yellow = Color(0xFFFFC700);
const Color green = Color(0xFFB6E3B6);
const Color white = Colors.white;

/// JSON schema for RecipeCard
final _recipeCardSchema = S.object(
  description: 'Card displaying summary information of a recipe',
  properties: {
    'title': S.string(
      description: 'Recipe title (e.g. Oven Baked Chicken with Potatoes)',
    ),
    'duration': S.string(
      description: 'Total preparation and cooking time (e.g. 45 minutes)',
    ),
    'difficulty': S.string(
      description: 'Difficulty level: Easy, Medium, or Hard',
      enumValues: ['Easy', 'Medium', 'Hard'],
    ),
    'imageDescription': S.string(
      description: 'Visual description of the dish (emoji)',
    ),
  },
  required: ['title', 'duration', 'difficulty'],
);

/// RecipeCard CatalogItem definition
final recipeCardItem = CatalogItem(
  name: 'RecipeCard',
  dataSchema: _recipeCardSchema,
  widgetBuilder: (itemContext) {
    final json = itemContext.data as Map<String, Object?>;
    final title = json['title'] as String? ?? 'Recipe';
    final duration = json['duration'] as String? ?? '';
    final difficulty = json['difficulty'] as String? ?? 'Medium';
    final imageDescription = json['imageDescription'] as String? ?? '🍽️';

    Color difficultyColor;
    switch (difficulty) {
      case 'Easy':
        difficultyColor = green;
        break;
      case 'Hard':
        difficultyColor = red;
        break;
      default:
        difficultyColor = yellow;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: black, width: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // IMAGE BLOCK
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: yellow,
              border: Border(
                bottom: BorderSide(color: black, width: kBorder),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              imageDescription,
              style: const TextStyle(fontSize: 64),
            ),
          ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),

                // META ROW
                Row(
                  children: [
                    // DURATION
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: white,
                        border:
                            Border.all(color: black, width: kBorder),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // DIFFICULTY
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: difficultyColor,
                        border:
                            Border.all(color: black, width: kBorder),
                      ),
                      child: Text(
                        difficulty.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
);
