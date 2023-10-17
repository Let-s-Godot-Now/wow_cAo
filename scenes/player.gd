extends CharacterBody2D

@export var Bullet: PackedScene
@onready var Camera = $"CameraAnchor/Camera2D"
@onready var CameraAnchor = $"CameraAnchor"
const DEFAULT_SPEED = 700
const FIRE_SPEED = 500
var speed

var shoot_timer = 0

@export var fire_rate = 0.1
var actual_rate = 0.1


func _ready():
	Camera.set("position", Vector2(40, 0))
	speed = DEFAULT_SPEED
	pass


func _physics_process(delta):
	shoot_timer += delta

	if Input.get_action_raw_strength("Shoot") && shoot_timer >= actual_rate:
		var _bullet = Bullet.instantiate()
		add_sibling(_bullet)
		_bullet.global_position = global_position
		_bullet.set(
			"area_direction", (get_global_mouse_position() - self.global_position).normalized()
		)
		Camera.set("offset", Vector2(randf_range(-4, 4), randf_range(-4, 4)))
		shoot_timer = 0
		speed = FIRE_SPEED
	else:
		Camera.set("offset", Vector2(0, 0))
		speed = DEFAULT_SPEED

	var direction_x = Input.get_axis("Left", "Right")
	var direction_y = Input.get_axis("Up", "Down")
	velocity.x = 0
	velocity.y = 0

	Camera.set("offset", Vector2(0, 0))

	if direction_x:
		velocity.x = direction_x * speed
	if direction_y:
		velocity.y = direction_y * speed

	CameraAnchor.look_at(get_global_mouse_position())

	move_and_slide()
