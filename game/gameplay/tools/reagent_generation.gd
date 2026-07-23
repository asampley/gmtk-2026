class_name ReagentGeneration


var reagent: Reagent
var cooldown_s: float
var max_reagents: int = 1

var timer_s: float
var current_reagents: int


func initialize(template_in: ReagentGenerationTemplate) -> void:
	reagent = template_in.reagent
	cooldown_s = template_in.cooldown_s
	max_reagents = template_in.max_reagents

func update(delta: float) -> void:
	timer_s =- delta
	if timer_s <= 0:
		timer_s = 0
		if current_reagents < max_reagents:
			current_reagents += 1
			timer_s = cooldown_s
