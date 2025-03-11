extends Node2D

var obstacle = preload("res://scenes/scenes_letter_u/FallingObject.tscn")  # Preload scena
var t = randf_range(1.2, 2)  # Interval aleatoriu pentru timer (poți folosi dacă vrei)
@onready var player = $Player  # Referință la nodul Player


func _ready():
	$Timer.start(t)  # Pornește timer-ul pentru instanțierea periodică

func _on_timer_timeout() -> void:
	if player.score >= 10:$Timer.stop()
	var screen = get_viewport_rect().size  # Obține dimensiunea ecranului
	var position = Vector2(randf_range(0, screen.x), -600)  # Poziționează obiectul aleatoriu pe X și afacerea ecranului pe Y

	var obstacle = load("res://scenes/scenes_letter_u/FallingObject.tscn")
	obstacle = obstacle.instantiate()  # Instanțiază scena încărcată
	obstacle.position = position  # Setează poziția obiectului căzător
	add_child(obstacle)  # Adaugă obiectul căzător în scenă
