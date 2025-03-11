extends Node

var played_intro = false
var skip_intro = true
var total_lives = 3  
var finished_C = false 
var skip_e_dialogue = true
var save_file_path: String = "res://player/player_data.txt"
var loaded_coins: bool = false
var obiecte_e = 10

var litere_necompletate : Array[String] = ["Litera_E", "Litera_I", "Litera_O", "Litera_U",
	"Litera_M", "Litera_B", "Litera_C", "Litera_D", "Litera_F",
	"Litera_G", "Litera_H", "Litera_J", "Litera_K", "Litera_L",
	"Litera_N", "Litera_P", "Litera_Q", "Litera_R", "Litera_S",
	"Litera_T", "Litera_V", "Litera_W", "Litera_X", "Litera_Y",
	"Litera_Z"]
	

func save_player_data() -> void:
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	if file:
		file.store_line(str(Player.coins))
		file.close()
		print("Player data saved: Coins =", Player.coins)
	else:
		print("Failed to save player data.")

func load_player_data() -> void:
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	if file:
		if file.eof_reached() == false:
			Player.coins = int(file.get_line())
			print("Player data loaded: Coins =", Player.coins)
		file.close()
	else:
		print("No save file found. Starting with 0 coins.")

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:  
		save_player_data()
		get_tree().quit()
