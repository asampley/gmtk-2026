extends Label


func _ready() -> void:
	EventBus.debug_events.toggle_fps_counter.connect(on_toggle_fps_counter)

func _process(_delta: float) -> void:
	text = "FPS: %s" % [Engine.get_frames_per_second()]

func on_toggle_fps_counter() -> void:
	visible = !visible
