extends Area2D

const SPEED:float = 2000.0
var area_direction:Vector2 = Vector2(0, 0)


func _ready():
	# 不知道有什么用，但看起来好看点
	self.get_node("BulletParticles").gravity = area_direction


func _process(delta):
	self.translate(area_direction * SPEED * delta)


func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.area_direction = area_direction
		body.hit()
	if not body.is_in_group("Player"):
		if self.has_node("BulletParticles"):
			self.get_node("BulletParticles/Timer").start()
			self.get_node("BulletParticles").reparent(get_parent().get_parent())
		queue_free()
