extends Node2D
@onready var start: Button = $Intro/Start


func _ready() -> void:
	Game.play_sound($Intro)
	start.pressed.connect(_on_start_pressed)

func _on_start_pressed() -> void:
	print("Start button pressed!")
	get_tree().change_scene_to_file("res://joc_cavaler/game.tscn") 
	
