class_name OffscreenRemover
extends VisibleOnScreenNotifier2D

## Root node is the node to remove when offscreen. Sprite required for dimensions.
## Removes any offscreen objects.

@export var root_node: Node
@export var sprite: Sprite2D

var has_entered: bool = false


func _ready() -> void:
	rect = sprite.get_rect()

func _on_screen_entered() -> void:
	has_entered = true

func _on_screen_exited() -> void:
	root_node.queue_free()
