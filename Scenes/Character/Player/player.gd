extends CharacterBody2D

@export var Bullet: PackedScene
@onready var Camera = $"PlayerCamera/CameraAnchor/Camera"
@onready var CameraAnchor = $"PlayerCamera/CameraAnchor"
@onready var Health: Node = $"Health"
@onready var HealthBar:ProgressBar

const DEFAULT_SPEED: float = 700.0
const FIRE_SPEED: float = 500.0
var speed: float

var shoot_timer: float = 0

@export var fire_rate: float = 0.1
var actual_rate: float = 0.1


func _ready():
	HealthBar=get_parent().get_node("CanvasLayer").get_node("HealthBar")
	Camera.set("position", Vector2(40, 0))
	speed = DEFAULT_SPEED


func _physics_process(delta):
	shoot_timer += delta

	if Input.get_action_raw_strength("Shoot") && shoot_timer >= actual_rate:
		var _bullet = Bullet.instantiate()
		add_sibling(_bullet)
		_bullet.global_position = global_position
		_bullet.set(
			"area_direction", (get_global_mouse_position() - self.global_position).normalized()
		)
		Camera.shake(0.5, 20, 10)
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


func _on_area_2d_area_entered(area: Area2D):
	if area.get_parent().is_in_group("Enemy"):
		Health.value -= 5
		HealthBar.value = Health.value
		$AnimationPlayer.play("damage")
		if Health.value <= 0:
			queue_free()
