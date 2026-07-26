class_name PopupBox
extends TextureRect


@export var bright: Color = Color("cf573c")
@export var dark: Color = Color("411d31")
@export var duration_s: float = .5

var tween: Tween


func _ready() -> void:
	if visible:
		modulate = dark
		bright_tween()

func bright_tween() -> void:
	tween = create_tween()
	tween.tween_property(self, "modulate", bright, duration_s)
	
	await tween.finished
	tween.kill()
	dark_tween()

func dark_tween() -> void:
	tween = create_tween()
	tween.tween_property(self, "modulate", bright, duration_s)
	
	await tween.finished
	tween.kill()
	bright_tween()
