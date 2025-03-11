extends Area2D

signal player_died
@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("You died")
	print("trimite semnal")
	emit_signal("player_died")
	Engine.time_scale=0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	


	
