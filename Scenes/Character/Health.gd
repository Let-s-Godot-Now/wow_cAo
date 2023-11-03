extends Node2D

@export var show_top_health_bar: bool = true

@onready var top_health_bar: ProgressBar = get_node("TopHealthBar")

var health: int = 100:
	set(h):
		health = h


func _ready() -> void:
	top_health_bar.visible = show_top_health_bar
