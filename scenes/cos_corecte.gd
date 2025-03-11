extends PanelContainer

@onready var corect: AudioStreamPlayer = $"../Corect"
@onready var gresit: AudioStreamPlayer = $"../Gresit"
@onready var win: AudioStreamPlayer = $"../Win"
@onready var dialog_win: AudioStreamPlayer = $"../Dialog_Win"
@onready var coin: AudioStreamPlayer = $"../Coin"


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data[0] is PanelContainer

	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if 'e' in data[1] or 'E' in data[1]:
		data[0].queue_free()
		Game.play_sound(corect)
		Globals.obiecte_e -= 1
	else:
		Game.play_sound(gresit)
		
	if Globals.obiecte_e == 0:
		Game.play_sound(win)
		win.connect("finished",Callable(self,"_on_instructions_finished"))

func _on_instructions_finished() -> void:
	Game.play_sound(dialog_win)
	dialog_win.connect("finished",
	func(): 
		Game.play_sound(coin)
		Player.coins +=5 
		get_tree().change_scene_to_file("res://scenes/levels.tscn") )
	
