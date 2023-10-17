extends Marker2D

@export var Enemy: PackedScene

@export var spawn_interval = Vector2(1, 5)

func _ready():
	randomize()
	$Timer.set_wait_time(randf_range(1,5))
	$Timer.start()


func spawn():
	randomize()
	var temp = Enemy.instantiate()
	temp.global_position = self.global_position + Vector2(randf_range(-2, 2), randf_range(-2, 2))
	add_sibling(temp)
	$Timer.set_wait_time(randf_range(1,5))

