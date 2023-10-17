extends CharacterBody2D

@export_group("Stats")
@export var speed = 200.0
@export var health: int = 1

var player: CharacterBody2D


func _ready():
	player = get_parent().get_node("Player")
	pass  # Replace with function body.


func _process(delta):
	if player != null:
		self.velocity = Vector2(0, 0)
		self.position.x = move_toward(self.position.x, player.get("position").x, speed * delta)
		self.position.y = move_toward(self.position.y, player.get("position").y, speed * delta)

	move_and_slide()

func hit():
	$KilledParticles.set_emitting(true)
	$KilledParticles.reparent(get_parent().get_parent())

	self.queue_free()
