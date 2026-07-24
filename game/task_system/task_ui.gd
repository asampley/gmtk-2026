class_name TaskUI
extends RichTextLabel


func initialize(text_in: String) -> void:
	text = text_in

func complete() -> void:
	text = "[s]"+ text + "[/s]"
