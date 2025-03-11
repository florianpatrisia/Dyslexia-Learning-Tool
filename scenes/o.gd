extends Node2D

@onready var explain_litera=$SFX/ExplainLiteraO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	explain_litera.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
