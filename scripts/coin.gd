extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coin_9: Area2D = $"../Coin9"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Bouncing parameters
var bounce_height = 10 # Height of the bounce
var bounce_speed = 2.0 # Speed of the bounce
var initial_position = Vector2.ZERO # To store the initial position
var time_passed = 0.0 # Tracks the time elapsed for the bounce

func _ready() -> void:
	# Store the initial position when the scene starts
	initial_position = animated_sprite_2d.position

func _process(delta: float) -> void:
	# Increment the time passed
	time_passed += delta

	# Calculate the bounce offset based on the sine wave
	var bounce_offset = sin(time_passed * bounce_speed) * bounce_height

	# Update the position of the sprite to make it bounce
	animated_sprite_2d.position = initial_position + Vector2(0, bounce_offset)

func _on_body_entered(body: Node2D) -> void:
	print("+1 coin")
	animation_player.play("pickup")
	game_manager.add_point()

func _on_coin_9_body_entered(body: Node2D) -> void:
	print("+1 coin")
	animation_player.play("pickup")
	game_manager.add_point()
	print(" a intrat in ultimul coin")
	Globals.finished_C = true
	Globals.total_lives = 0
	get_tree().reload_current_scene()
