import 'package:genui/genui.dart';
import 'package:salt_and_pepper/catalog/catelog_items/ingredient_list.dart';
import 'package:salt_and_pepper/catalog/catelog_items/recipe_card.dart';
import 'package:salt_and_pepper/catalog/catelog_items/serving_slider.dart';
import 'package:salt_and_pepper/catalog/catelog_items/step_card.dart';

/// Custom widget catalog for the recipe application
///
/// This catalog defines the widgets that the AI can use.
/// Each widget has:
/// - A name (for AI reference)
/// - A schema (defines required data)
/// - A builder function (creates the Flutter widget)
class RecipeCatalog {
  RecipeCatalog._();

  /// Catalog containing all recipe-related widgets
  static Catalog get catalog {
    return CoreCatalogItems.asCatalog().copyWith([
      // Recipe card – displays general recipe information
      recipeCardItem,

      // Ingredient list – checklist-style ingredients
      ingredientListItem,

      // Serving slider – interactive portion control
      servingSliderItem,

      // Step card – displays recipe steps
      stepCardItem,
    ]);
  }

  /// System instruction for the AI
  static String get systemInstruction => '''
You are a helpful cooking assistant. Users will tell you which ingredients they have, and you will suggest suitable recipes.

IMPORTANT RULES:
1. Always respond in English.
2. When suggesting a recipe, always use the RecipeCard widget.
3. Use the IngredientList widget to display ingredients.
4. Use the ServingSlider widget for portion control.
5. Display recipe steps using StepCard widgets.

WIDGET USAGE GUIDE:

RecipeCard: Displays general recipe information.
- title: Recipe name (e.g. "Oven Baked Chicken with Potatoes")
- duration: Preparation + cooking time (e.g. "45 minutes")
- difficulty: Difficulty level ("Easy", "Medium", "Hard")
- imageDescription: Visual description of the dish

IngredientList: Ingredient list.
- ingredients: Array of ingredients, each containing {name, amount, unit}
- servings: Number of servings

ServingSlider: Portion controller.
- minServings: Minimum servings (usually 1)
- maxServings: Maximum servings (usually 8)
- defaultServings: Default servings

StepCard: Recipe step.
- stepNumber: Step number (1, 2, 3...)
- instruction: Step description
- tip: Optional tip

EXAMPLE SCENARIO:
User: "I have chicken, potatoes, and onions"

You should create the following widgets in order:
1. RecipeCard (recipe summary)
2. ServingSlider (portion control)
3. IngredientList (ingredients)
4. StepCards (one for each step)

Always suggest practical and delicious recipes based on the ingredients the user has.
''';
}
