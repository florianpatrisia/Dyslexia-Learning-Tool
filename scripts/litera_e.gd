extends Node2D

var obiecte = ['Elan','Carne','Leu','Elefant','Albina','Pui','Gaina','Caine','Cal','Zebra']


func _ready() -> void:
	var audio_player = $Intro

	if Globals.skip_e_dialogue == false:
		Game.play_sound(audio_player)
		
		audio_player.connect("finished", Callable(self, "_on_sound_finished"))
	else:
		_on_instructions_finished()

func _on_sound_finished() -> void:
	var next_audio_player = $Instructiuni
	Game.play_sound(next_audio_player)
	next_audio_player.connect("finished",Callable(self,"_on_instructions_finished"))

func _on_instructions_finished() -> void:
	var nodes = $Control.get_children()
	for node in nodes:
		if node.name in obiecte and node is PanelContainer:
			node.visible = true
		
