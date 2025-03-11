extends Control

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn") 
	
#func _ready() -> void:
	#if not Globals.loaded_coins:
		#Globals.load_player_data()
		#Globals.loaded_coins = true
	#$PanelContainer/HBoxContainer/Coins.text = str(Player.coins)

#func _process(delta):
	#print("in process")
	#if Globals.finished_C and not audio_stream_player_2d.playing:
		#print("Playing audio...")
		#audio_stream_player_2d.play()  # Play the audio
		#Globals.finished_C = false  # Reset to prevent replaying continuously
		#


func _on_litera_u_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scenes_letter_u/GameWorld.tscn") 


func _on_silabe_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/silabe.tscn") 


func _on_litera_c_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scenes_letter_c/letter_c_start.tscn")


func _on_litera_s_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/scenes_letter_s/letter_s_start.tscn")


func _on_litera_b_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scenes_letter_b/litera_b.tscn") 


func _on_litera_i_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scenes_letter_i/letter_i_start_int.tscn")
