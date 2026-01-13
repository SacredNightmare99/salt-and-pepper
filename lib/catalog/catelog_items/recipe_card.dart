import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// JSON schema for RecipeCard
/// AI will generate data according to this schema
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
    final context = itemContext.buildContext;
    final json = itemContext.data as Map<String, Object?>;
    final title = json['title'] as String? ?? 'Recipe';
    final duration = json['duration'] as String? ?? '';
    final difficulty = json['difficulty'] as String? ?? 'Medium';
    final imageDescription = json['imageDescription'] as String? ?? '🍽️';

    // Color based on difficulty level
    Color difficultyColor;
    switch (difficulty) {
      case 'Easy':
        difficultyColor = Colors.green;
        break;
      case 'Hard':
        difficultyColor = Colors.red;
        break;
      default:
        difficultyColor = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top section – image area
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  imageDescription,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),

            // Bottom section – details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Duration and difficulty
                  Row(
                    children: [
                      // Duration
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              duration,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Difficulty
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: difficultyColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: difficultyColor.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          difficulty,
                          style: TextStyle(
                            color: difficultyColor,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  },
);
