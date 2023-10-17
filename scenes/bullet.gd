extends Area2D

const SPEED = 2000.0
var area_direction = Vector2(0, 0)
var debounce = false


func _ready():
	# 不知道有什么用，但看起来好看点
	self.get_node("BulletParticles").gravity = area_direction


func _process(delta):
	self.translate(area_direction * SPEED * delta)


func _on_body_entered(body):
	print("hit")
	if body.is_in_group("Enemy"):
		body.hit()
	if not body.is_in_group("Player"):
		$BulletParticles.reparent(get_parent().get_parent())
		queue_free()
