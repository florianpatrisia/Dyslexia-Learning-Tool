extends Node2D

var score = 0
var checks = {
	"dog": false,
	"cow": false,
	"cat": false,
	"frog": false,
	"duck": false
}

var expected_checks = {
	"dog": false,
	"cow": true,
	"cat": false,
	"frog": true,
	"duck": true
}

@onready var dog_button = $Control/DogPanel/CheckButton
@onready var cow_button = $Control/CowPanel/CheckButton
@onready var cat_button = $Control/CatPanel/CheckButton
@onready var frog_button = $Control/FrogPanel/CheckButton
@onready var duck_button = $Control/DuckPanel/CheckButton

var checked_image = preload("res://assets/images/letter_m/check_mark.png")
var unchecked_image = preload("res://assets/images/letter_m/empty_check_mark.png")

@onready var score_dialog = $ScoreDialog
@onready var timer = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_dialog.visible = false;
	_set_buttons_enabled(false)
	$IntroA.play()
	$IntroA.connect("finished", Callable(self, "_on_intro_finished"))

func _on_intro_finished() -> void:
	_set_buttons_enabled(true);
	
func _set_buttons_enabled(state: bool) -> void:
	$Verify.disabled = !state
	var control = $Control
	for animal_panel in control.get_children():
		if animal_panel is VBoxContainer:
			for button in animal_panel.get_children():
				if button is Button:
					print("ok")
					button.disabled = !state 

func _on_dog_pressed() -> void:
	$Dog.play()

func _on_cow_pressed() -> void:
	$Cow.play()

func _on_cat_pressed() -> void:
	$Cat.play()

func _on_frog_pressed() -> void:
	$Frog.play()

func _on_duck_pressed() -> void:
	$Duck.play()
	
func update_button_image(button: Button, animal: String) -> void:
	if checks[animal]:
		button.icon = checked_image
	else:
		button.icon = unchecked_image

func _on_check_dog_button_pressed() -> void:
	checks["dog"] = !checks["dog"]
	update_button_image(dog_button, "dog")

func _on_check_cow_button_pressed() -> void:
	checks["cow"] = !checks["cow"]
	update_button_image(cow_button, "cow")

func _on_check_cat_button_pressed() -> void:
	checks["cat"] = !checks["cat"]
	update_button_image(cat_button, "cat")

func _on_check_frog_button_pressed() -> void:
	checks["frog"] = !checks["frog"]
	update_button_image(frog_button, "frog")

func _on_check_duck_button_pressed() -> void:
	checks["duck"] = !checks["duck"]
	update_button_image(duck_button, "duck")


func _on_verify_pressed() -> void:
	score = 0
	var animals = ["dog", "cow", "cat", "frog", "duck"]
	for animal in animals:
		if checks[animal] == expected_checks[animal]:
			score += 1
	score *= 2
	print(score)
	_set_buttons_enabled(false)
	score_dialog.visible = true
	score_dialog.get_child(0).text = " Felicitări! Ai obținut %d puncte." % score
	timer.start()
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/levels.tscn")
