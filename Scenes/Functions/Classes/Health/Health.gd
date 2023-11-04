extends Node
class_name Health

@export var show_top_health_bar: bool = true

# @onready var top_health_bar: ProgressBar = get_node("TopHealthBar")

var value: int = 100:
	set(h):
		value = h
		value = clampi(h, 0, 100)
		print(value)


func _ready() -> void:
	# top_health_bar.visible = show_top_health_bar
	pass
