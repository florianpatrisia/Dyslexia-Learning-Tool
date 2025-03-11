extends Control

var letters = ["A", "B", "C", "D", "E", "O", "F", "G", "H"]  # Lista de litere
var target_letter = "O"  # Litera de găsit
var time_left = 30  # Timp rămas în secunde
var score = 0  # Punctajul

# Noduri UI
@onready var timer_label = $TimerLabel
@onready var score_label = $ScoreLabel
var found_buttons = []
var button_labels = {}
var coin_start_position: Vector2
var label_start_position: Vector2
var target_position: Vector2 = Vector2(650, 50)
var animation_duration: float = 1.0
var elapsed_time: float = 0.0
var coin: Sprite2D
var plus_one_label: Label
var animating: bool = false
func _ready():
	# Inițializare joc
	generate_letters(10)  # Generează 10 litere pe ecran
	start_timer()  # Pornește cronometrul
	update_score()  # Actualizează afișarea punctajului


func generate_letters(count):
	var random = RandomNumberGenerator.new()
	random.randomize()
	var o_added = 0  # Vom număra câte litere "O" am adăugat
	var total_o_count = 2  # Dorim să avem cel puțin 2 litere "O"

	# Lista de litere
	var letters_list = []
	
	# Adăugăm manual cele 2 litere "O" la început
	while o_added < total_o_count:
		letters_list.append("O")
		o_added += 1

	# Adăugăm restul literelor aleatorii
	for i in range(count - total_o_count):  # Scădem cele 2 litere "O"
		var letter = letters[random.randi_range(0, letters.size() - 1)]
		letters_list.append(letter)
	
	# Acum generăm butoanele pentru fiecare literă
	for letter in letters_list:
		var letter_button = preload("res://scenes/letter-button.tscn").instantiate()  # Încarcă butonul
		add_child(letter_button)
		letter_button.add_to_group("buttons")  # Adaugă butonul în grupul "buttons"
		
		# Setează textul literei și poziția random
		letter_button.letter = letter
		letter_button.set_size(Vector2(40, 40))
		letter_button.position = Vector2(
			random.randi_range(0, 800),  # Poziție X (înlocuiește 800 cu dimensiunea ecranului)
			random.randi_range(0, 600)   # Poziție Y
		)
		
		# Creează și adaugă un label pentru literă
		var letter_label = Label.new()
		letter_label.text = letter
		letter_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		letter_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		letter_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		letter_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
		letter_label.anchor_left = 0
		letter_label.anchor_right = 1
		letter_label.anchor_top = 0
		letter_label.anchor_bottom = 1
		letter_button.add_child(letter_label)
		
		# Salvează label-ul pentru fiecare buton
		button_labels[letter_button] = letter_label
		
		# Marchează litera "O" drept țintă
		letter_button.is_target = (letter == target_letter)
		
		# Modifică semnalul pentru a trimite butonul
		letter_button.connect("pressed", Callable(self, "_on_letter_pressed").bind(letter_button))



		# Conectează semnalul "pressed" al butonului la un script separat
		#letter_button.connect("pressed", letter_button, "_on_pressed")
func _on_letter_pressed(letter_button):
	var letter_label = button_labels.get(letter_button)
	if letter_label:
		var letter = letter_label.text
	# Verifică dacă litera apăsată este ținta
		if letter == target_letter:
		# Crește punctajul
			show_coin_effect(letter_button.position)
			score += 1
			update_score()
			found_buttons.append(letter_button)
			letter_button.remove_from_group("buttons")
			
		# Verifică dacă toate literele "O" au fost găsite
			check_victory()
	
func update_score():
	# Actualizează afișarea punctajului
	score_label.text = "Punctaj: %d" % score

func check_victory():
	print("am intrat in check")
	# Verifică dacă toate literele "O" au fost găsite
	var remaining_targets = get_tree().get_nodes_in_group("buttons").filter(func(button):
		return button.is_target and not button in found_buttons
	)

	if remaining_targets.size() == 0:
		print("Felicitări! Ai găsit toate literele O!")
		get_tree().change_scene_to_file("res://scenes/finish_lit_o.tscn")
		#get_tree().change_scene("res://scenes/victory.tscn")  # Încarcă scena de victorie (dacă există)

func start_timer():
	# Creează un timer și pornește cronometrul
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.autostart = true
	timer.connect("timeout", Callable(self, "_on_timer_tick"))

	timer.start()

func _on_timer_tick():
	print("Timer ticked!")  # Verifică dacă această linie se execută
	time_left -= 1
	timer_label.text = "Timp: %d secunde" % time_left
	if time_left <= 0:
		game_over()


func game_over():
	print("Timpul a expirat! Scorul tău este: %d" % score)
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")  # Încarcă scena de final (dacă există)
func show_coin_effect(start_position):
	# Creează sprite-ul pentru coin
	coin = Sprite2D.new()
	coin.texture = preload("res://assets/images/buuton_lit_o.png")	
	coin.scale = Vector2(0.05, 0.05)
	add_child(coin)
	coin.position = start_position
	coin_start_position = start_position
	#coin.set_size(Vector2(40, 40))
	# Creează un label pentru "+1"
	plus_one_label = Label.new()
	plus_one_label.text = "+1"
	
	
	var font  = FontFile.new()  # Creează un FontFile
	font=preload("res://assets/fonts/Comic Sans MS.ttf")  # Înlocuiește cu calea reală a fișierului de font
	
	plus_one_label.add_theme_color_override("font_color", Color(0, 0, 0))
	plus_one_label.add_theme_font_size_override("font_size",24)
	# Aplică fontul la label
	plus_one_label.add_theme_font_override("font", font)
	add_child(plus_one_label)
	plus_one_label.position = start_position + Vector2(0, -30)
	label_start_position = plus_one_label.position

	# Începe animația
	animating = true
	elapsed_time = 0.0  # Resetează timpul
func _process(delta):
		if animating:
			elapsed_time += delta
			var t = elapsed_time / animation_duration
			if t > 1.0:
				t = 1.0
				animating = false
				_on_animation_complete()  # Termină animația

		# Interpolează poziția
			coin.position = coin_start_position.lerp(target_position, t)
			plus_one_label.position = label_start_position.lerp(target_position + Vector2(0, -30), t)
func _on_animation_complete():
	# Curăță nodurile după animație
	if coin:
		coin.queue_free()
	if plus_one_label:
		plus_one_label.queue_free()
