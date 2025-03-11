extends TextureButton

var label_text 
var is_target = false  # Indică dacă aceasta este litera "O"
signal letter_pressed(letter)
var letter = ""

func _ready() -> void:
	label_text=$Label
	label_text.text = letter

func _on_pressed() -> void:
	if is_target:
		modulate = Color(0, 1, 0) 
		print("Ai găsit litera O!")
		queue_free()  # Elimină litera găsită de pe ecran
	else:
		print("Aceasta nu este litera O!")
		modulate = Color(1, 0, 0)
	emit_signal("letter_pressed", letter)
