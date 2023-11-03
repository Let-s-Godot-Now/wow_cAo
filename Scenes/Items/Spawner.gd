extends Marker2D

@export var Enemy: PackedScene

@export var spawn_interval: Vector2 = Vector2(1, 5)

var tilemap: TileMap


func _ready():
	randomize()
	tilemap = get_parent().get_parent().get_node("TileMap")
	$Timer.set_wait_time(randf_range(1, 5))
	$Timer.start()
	print(tilemap.get_used_rect().end.x * tilemap.tile_set.tile_size.x * 6)


func spawn() -> void:
	randomize()
	get_node("AnimationPlayer").play("spawn")
	var temp = Enemy.instantiate()
	temp.global_position = self.global_position + Vector2(randf_range(-2, 2), randf_range(-2, 2))
	GlobalValue.scene_root_node.add_child(temp)
	$Timer.set_wait_time(randf_range(1, 5))
	var used = tilemap.get_used_rect()
	var tile_size = tilemap.tile_set.tile_size * 6
	position = Vector2(
		randf_range(used.position.x * tile_size.x, used.end.x * tile_size.x),
		randf_range(used.position.y * tile_size.y, used.end.y * tile_size.y)
	)
	# position=Vector2(randf_range(0, tilemap.get_used_rect().size.x), randf_range(0, tilemap.get_used_rect().size.y))
