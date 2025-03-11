class_name Enemy extends Area2D

signal killed(points)
signal killedwrong(points)
signal hit

@export var speed = 70
@export var hp = 1
@export var points = 100
#@onready var enemy_nonlethal = $enemy_nonlethal

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		if self.is_in_group("enemy_nonlethal"):
			print("Am intrat în enemy_nonlethal")
		else:
			body.die()
			die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		if self.is_in_group("enemy_nonlethal"):
			killedwrong.emit(points)
			die()
		killed.emit(points)
		die()
	else:
		hit.emit()
