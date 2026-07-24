# Only holds progress, no driving logic
# This is to cache values before reagents change
class_name ReactionProgress

var recipe_progress: Dictionary[Recipe, RecipeProgress] = {}
var reagent_states: Dictionary[Reagent, Variant] = {}

class RecipeProgress:
	var progress: float = 0.0
	var time_multiplier: float = 1.0
	var estimated_remaining: float = 0.0

enum ReagentState {
	DESIRABLE_REACTION,
	REACTION,
	STABLE,
}
