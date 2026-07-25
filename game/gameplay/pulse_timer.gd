extends Node


var pulse_time_s: float
var time_elapsed_s: float

signal pulse()


func _process(delta: float) -> void:
	time_elapsed_s += delta
	if time_elapsed_s >= pulse_time_s:
		pulse.emit()
		time_elapsed_s -= 1
