extends Node2D

var selected_objects = []
var correct_objects = ["brad", "buburuza", "bec", "balon"]
var all_objects = ["brad", "buburuza", "bec", "balon", "albina", "elefant", "urs"]


func _ready() -> void:
	print("Start joc...")
	Game.play_sound($Explicatie_joc_B)


	for child in get_children():
		if child is Button:
			child.connect("pressed", Callable(self, "_on_button_pressed").bind(child))

func _on_button_pressed(button: Button):
	var object_name = button.name

	print("S-a apăsat pe obiect:", object_name)

	if object_name in selected_objects:
		selected_objects.erase(object_name)
	else:
		selected_objects.append(object_name) 

	print("Selectat:", selected_objects)
	check_win_condition()

func check_win_condition():
	var is_correct = true

	for obj in correct_objects:
		if obj not in selected_objects:
			is_correct = false
			break

	for obj in selected_objects:
		if obj not in correct_objects:
			is_correct = false
			break

	if is_correct:
		print("Joc finalizat cu succes!")
		get_tree().change_scene_to_file("res://scenes/scenes_letter_b/sfarsit_litera_b.tscn") 
