extends CanvasLayer

var heart_texture = preload("res://joc_cavaler/assets/sprites/heart.png")  # Heart icon texture
var hearts = []
var player : Node  # Declare player variable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("randeaza")
	print(Globals.total_lives)
	if Globals.total_lives==0:
		print("merge in scena de sfarsit")
		Globals.finished_C = true;
		Globals.total_lives=3
		await get_tree().create_timer(1.1).timeout  
		get_tree().change_scene_to_file("res://scenes/levels.tscn")
	else:
		for i in range(Globals.total_lives):
			var heart = TextureRect.new()
			heart.texture = heart_texture
			heart.position = Vector2(1100 - i * 40, 20) 
			heart.scale = Vector2(0.2, 0.2) 
			add_child(heart)
			hearts.append(heart)
		
		Globals.total_lives-=1
	


# Update the UI based on remaining lives
func update_lives(lives_left):
	for i in range(len(hearts)):
		if i < lives_left:
			hearts[i].show()  # Show heart
		else:
			hearts[i].hide()  # Hide heart

	if lives_left <= 0:
		# End the game if no lives left
		get_tree().paused = true  # Pause the game or show game over screen
		print("Game Over!")
