extends Node2D
@onready var finish=$SFX/finish_lit_o

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finish.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_inapoi_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels.tscn") 
