extends Node

var words = [
	{"word": "casă", "correct_syllables": "ca-să", "options": ["ca-să", "c-as-ă", "cas-ă", "ca-s-ă"]},
	{"word": "educație", "correct_syllables": "e-du-ca-ție", "options": ["e-du-ca-ți-e", "edu-ca-ție", "e-du-ca-ție", "educ-ație"]},
	{"word": "carte", "correct_syllables": "car-te", "options": ["ca-rte", "car-te", "cart-e", "c-ar-te"]},
	{"word": "macara", "correct_syllables": "ma-ca-ra", "options": ["mac-ar-a", "ma-ca-ra", "mac-ara", "ma-cara"]},
	{"word": "cană", "correct_syllables": "ca-nă", "options": ["can-ă", "ca-nă", "c-an-ă", "ca-n-ă"]},
	{"word": "mâncare", "correct_syllables": "mân-ca-re", "options": ["mân-care", "mâ-nca-re", "mân-ca-re", "mâs-ncar-e"]},
	{"word": "cadou", "correct_syllables": "ca-dou", "options": ["cad-ou", "c-ad-ou", "c-adou", "ca-dou"]}
]

var current_word = null

@onready var label_word = $WordLabel
@onready var button_container = $ButtonContainer

func _ready():
	Game.play_sound($explicatie_joc)
	randomize()
	load_next_word()
	

func load_next_word():
	if words.size() == 0:
		show_game_over()
		return

	current_word = words.pop_front()
	label_word.text = current_word["word"]
	create_buttons(current_word["options"])

func create_buttons(options):
	for child in button_container.get_children():
		child.queue_free()
	
	for option in options:
		var btn = Button.new()
		btn.text = option
		btn.pressed.connect(Callable(self, "_on_button_pressed").bind(option))
		button_container.add_child(btn)

func _on_button_pressed(option):
	if option == current_word["correct_syllables"]:
		Game.play_sound($corect)
		load_next_word()
	else:
		Game.play_sound($gresit)

func show_game_over():
	for child in button_container.get_children():
		child.queue_free()
	get_tree().change_scene_to_file("res://scenes/scenes_silaba_ca/sfarsit_silaba_ca.tscn") 
	#var btn_restart = Button.new()
	#btn_restart.text = "Reîncepe"
	#btn_restart.connect("pressed", Callable(self, "_restart_game"))
	#button_container.add_child(btn_restart)


func _restart_game():
	words = shuffle(words + [
	{"word": "casă", "correct_syllables": "ca-să", "options": ["ca-să", "c-as-ă", "cas-ă", "ca-s-ă"]},
	{"word": "educație", "correct_syllables": "e-du-ca-ție", "options": ["e-du-ca-ți-e", "edu-ca-ție", "e-du-ca-tie", "educ-ație"]},
	{"word": "carte", "correct_syllables": "car-te", "options": ["ca-rte", "car-te", "cart-e", "c-ar-te"]},
	{"word": "macara", "correct_syllables": "ma--ca-ra", "options": ["mac-ar-a", "ma--ca-ra", "mac-ara", "ma-cara"]},
	{"word": "cană", "correct_syllables": "ca-nă", "options": ["can-ă", "cană", "c-an-ă", "ca-n-ă"]},
	{"word": "mâncare", "correct_syllables": "mân-ca-re", "options": ["mân-care", "mâ-nca-re", "mân-ca-re", "mâs-ncar-e"]},
	{"word": "cadou", "correct_syllables": "ca-dou", "options": ["cad-ou", "c-ad-ou", "c-adou", "ca-dou"]}
	])
	load_next_word()

func shuffle(array):
	for i in range(array.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var aux= array[i]
		array[i]= array[j]
		array[j]= aux
	return array
