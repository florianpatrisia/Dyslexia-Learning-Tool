extends Node2D
@onready var intro_litera_b: AudioStreamPlayer = $Intro_Litera_B
@onready var inapoi: AudioStreamPlayer = $Inapoi
@onready var inceput_joc_b: AudioStreamPlayer = $Inceput_joc_B

func _ready() -> void:
	Game.play_sound(intro_litera_b)

func _on_inapoi_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels.tscn")


func _on_incepe_joc_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scenes_letter_b/joc_litera_b.tscn")


func _on_inapoi_mouse_entered() -> void:
	Game.play_sound($Inapoi)


func _on_incepe_joc_mouse_entered() -> void:
	Game.play_sound(inceput_joc_b)
