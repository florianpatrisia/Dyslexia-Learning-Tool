extends Node

func _ready() -> void:
	Game.play_sound($Felicitari)

func _on_inapoi_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels.tscn")

func _on_inapoi_mouse_entered() -> void:
	Game.play_sound($Inapoi)
