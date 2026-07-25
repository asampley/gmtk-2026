# Only holds progress, no driving logic
# This is to cache values before reagents change
class_name ReactionProgress

var recipe_progress: Dictionary[Recipe, RecipeProgress] = {}
var reagent_states: Dictionary[Reagent, Variant] = {}

class RecipeProgress:
	var paused: bool
	var time_multiplier: float = 1.0
	var total_time: int
	var remaining_time: int

enum ReagentState {
	DESIRABLE_REACTION,
	REACTION,
	STABLE,
}
