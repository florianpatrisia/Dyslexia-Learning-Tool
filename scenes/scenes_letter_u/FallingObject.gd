extends Area2D

@export var textures : Array = [
	preload("res://assets/images/letter_u/o.PNG"), 
	preload("res://assets/images/letter_u/e.PNG"),
	preload("res://assets/images/letter_u/m.PNG"),
	preload("res://assets/images/letter_u/b.PNG"),
	preload("res://assets/images/letter_u/c.PNG"),
	preload("res://assets/images/letter_u/f.PNG"),
	preload("res://assets/images/letter_u/uu.PNG"),
	preload("res://assets/images/letter_u/i.PNG"),
	preload("res://assets/images/letter_u/g.PNG"),
	preload("res://assets/images/letter_u/uu.PNG"),
	preload("res://assets/images/letter_u/uu.PNG"),
	preload("res://assets/images/letter_u/uu.PNG"),
	preload("res://assets/images/letter_u/uu.PNG")
]  # Listă de texteuri pentru obiectele căzătoare

var rng : RandomNumberGenerator = RandomNumberGenerator.new()  # RandomNumberGenerator pentru poziția inițială
var velocity : Vector2 = Vector2.ZERO  # Viteza obiectului
var fall_gravity : float = 200  # Gravitație pentru cădere

func _ready() -> void:
	# Setează poziția inițială pe axa Y aleatoriu, la o valoare între 5 și 10
	add_to_group("falling_objects")
	position.y = rng.randf_range(5, 10)

	# Setează textura aleatorie pentru obiect
	set_random_texture()

func set_random_texture():
	# Alege un index aleatoriu din lista de texteuri
	var random_index = rng.randi_range(0, textures.size() - 1)
	# Setează textura aleasă pe Sprite
	var sprite = $Sprite2D  # Asigură-te că ai un nod Sprite2D în scena FallingObject
	sprite.texture = textures[random_index]  # Aplică textura aleasă

func _process(delta: float) -> void:
	# Aplică gravitația la viteză pe axa Y
	velocity.y += fall_gravity * delta

	# Actualizează poziția obiectului pe baza vitezei
	position += velocity * delta

	# Dacă obiectul a ajuns la sol, oprește-l (sau îl poți șterge, de exemplu)
	if position.y > get_viewport_rect().size.y:  # Dacă depășește fereastra (solul)
		queue_free()  # Eliberează obiectul (poți schimba acest comportament cum vrei)
