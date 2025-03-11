extends Node

func _ready():
	Game.play_sound($poveste_silaba_ca)

func _on_inapoi_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/silabe.tscn")


func _on_incepe_jocul_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scenes_silaba_ca/joc_silaba_ca.tscn")


func _on_incepe_jocul_mouse_entered() -> void:
	Game.play_sound($Incepe_Jocul)


func _on_inapoi_mouse_entered() -> void:
	Game.play_sound($Inapoi)
