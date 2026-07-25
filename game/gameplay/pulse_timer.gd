extends Node


var pulse_time_s: float = 1.0
var ticks_per_pulse: int = 60
var time_elapsed_s: float

var _tick: int

signal pulse()
signal tick(i: int, per_pulse: int)


func _process(delta: float) -> void:
	time_elapsed_s += delta
	var tick_time_s := pulse_time_s / ticks_per_pulse
	if time_elapsed_s >= tick_time_s:
		tick.emit(_tick, ticks_per_pulse)
		if _tick == 0:
			pulse.emit()
		_tick = (_tick + 1) % ticks_per_pulse
		time_elapsed_s -= tick_time_s

