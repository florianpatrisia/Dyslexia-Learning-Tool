extends Area2D

@export var speed: int = 500
@export var player_size: Vector2 = Vector2(64, 64)  # Dimensiune exemplu (lățime, înălțime)
var velocity = Vector2()
var screen_size: Vector2
@onready var score_label: Label = $"/root/GameWorld/ScoreLabel" 
@onready var game_over_label: Label = $"/root/GameWorld/CongratulationLabel"  # Afișăm eticheta de Game Over
var score: int = 0

var game_over: bool = false  # Flag pentru a verifica dacă jocul s-a încheiat

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta: float):
	if game_over:
		return  # Oprirea mișcării și a logicii de procesare dacă jocul s-a încheiat

	velocity = Vector2.ZERO  # Resetăm viteza pe fiecare cadru
	
	# Detectăm acțiunile de intrare
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1  # Mișcare spre dreapta
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1  # Mișcare spre stânga

	# Normalizăm viteza, dacă este nevoie, și aplicăm viteza
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# Actualizăm poziția
	position += velocity * delta


# Funcția care va fi apelată atunci când jucătorul intră în coliziune cu un obiect căzător
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("falling_objects"):
		# Verificăm textura obiectului căzător
		var falling_object_sprite = area.get_node("Sprite2D")  # Asigură-te că nodul sprite se numește "Sprite2D"

		# Dacă textura este "uu.PNG", creștem scorul
		if falling_object_sprite.texture.resource_path == "res://assets/images/letter_u/uu.PNG":
			score += 1
		else:
			score -= 1

		# Actualizăm scorul afișat
		score_label.text = "Score: " + str(score)
		
		area.queue_free()
		# Verificăm dacă scorul a ajuns la 10
		if score >= 10:
			game_over = true  # Oprim jocul
			game_over_label.text = "Felicitări! Ai câștigat!" # Afișăm mesajul de felicitare
			game_over_label.visible = true  # Face GameOverLabel vizibil pe ecran

			# Așteptăm 5 secunde înainte de a schimba scena
			await get_tree().create_timer(5).timeout  # Așteaptă 5 secunde
			get_tree().change_scene_to_file("res://scenes/levels.tscn")  # Schimbă la scena principală (asigură-te că calea către scena principală este corectă)

		# Eliminăm obiectul căzător din scenă
