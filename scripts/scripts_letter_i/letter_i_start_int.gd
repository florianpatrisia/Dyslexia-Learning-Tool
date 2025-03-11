extends Control

@onready var play: Button = $HBoxContainer/play
@onready var exit: Button = $HBoxContainer/exit


func play_sound(soundNode: AudioStreamPlayer) -> void:
	soundNode.play()
	
func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_label_ready() -> void:
	if Globals.played_intro == false:
		print("Playing introduction!")
		play_sound($Introduction)
	if Globals.skip_intro == true:
		return


func _on_texture_rect_ready() -> void:
	$TextureRect.texture = preload("res://assets/images/letter_i_scene/bunny.png")


func _on_play_pressed() -> void:
	if Globals.skip_intro == true:
		pass
	elif $Introduction.is_playing():
		return
	get_tree().change_scene_to_file("res://scenes/scenes_letter_i/letter_i_start.tscn") 


func _on_exit_pressed() -> void:
	if Globals.skip_intro == true:
		pass
	elif $Introduction.is_playing():
		await $Introduction.finished
	get_tree().change_scene_to_file("res://scenes/levels.tscn") 


func _on_play_mouse_entered() -> void:
	if $Introduction.is_playing():
		await $Introduction.finished
	$Exit.stop()
	play_sound($Play)


func _on_exit_mouse_entered() -> void:
	if $Introduction.is_playing():
		await $Introduction.finished
	else:
		$Play.stop()
		play_sound($Exit)


func _on_introduction_finished() -> void:
	Globals.played_intro = true

func _on_play_finished() -> void:
	pass 


func _on_exit_finished() -> void:
	pass 
