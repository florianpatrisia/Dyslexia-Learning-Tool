class_name LocalPlayer extends CharacterBody2D

signal laser_shot(laser_scene, location)
signal killed


@export var speed = 300
@export var rate_of_fire := 0.25

@onready var muzzle = $Muzzle

var laser_scene = preload("res://joc-ma/scenes/laser.tscn")
#@onready var enemy_nonlethal = $enemy_nonlethal # Numele grupului inamicilor care nu provoacă moartea

var shoot_cd := false

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	velocity = direction * speed
	move_and_slide()
	
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)

func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)

func die():
	killed.emit()
	queue_free()
func _on_body_entered(body):
	# Verificăm dacă obiectul cu care ne-am lovit este un inamic sau alt tip de corp
	if body is Enemy:
		# Verificăm dacă inamicul este în grupul "enemy_nonlethal"
		if body.is_in_group("enemy_nonlethal"):
			print("Player collided with a non-lethal enemy.")
			# Do nothing or implement any logic for non-lethal enemies (e.g., avoid damage)
		else:
			print("Player collided with a lethal enemy.")
			die()  # Player dies if colliding with a lethal enemy
