extends Node

func _ready():
	Game.play_sound($felicitari_audio)

func _on_inapoi_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/silabe.tscn")
