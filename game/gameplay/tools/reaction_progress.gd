# Only holds progress, no driving logic
# This is to cache values before reagents change
class_name ReactionProgress


var time_elapsed_s: float = 0.0
var total_time_s: float
var progress_percent: float:
	get:
		return time_elapsed_s / total_time_s
var catalysts: Array[Catalyst]
var reagent_state: ReagentState

enum ReagentState {
	DESIRABLE,
	UNDESIRABLE,
	STABLE,
}


func initialize(decay_in: DecayTemplate) -> void:
	if decay_in:
		total_time_s = decay_in.time_s
		catalysts = decay_in.catalysts
		if decay_in.is_desirable:
			reagent_state = ReagentState.DESIRABLE
		else:
			reagent_state = ReagentState.UNDESIRABLE
	else:
		reagent_state = ReagentState.STABLE


func progress(delta: float, present_reagents: Array[Reagent]) -> bool:
	var catalyst_mult: float = 1.0
	for catalyst: Catalyst in catalysts:
		if present_reagents.has(catalyst.reagent):
			catalyst_mult *= catalyst.time_multiplier
	time_elapsed_s += delta * catalyst_mult
	return progress_percent >= 1.0
