extends Node2D

@export var enemy_scenes: Array[PackedScene] = [
	preload("res://joc-ma/scenes/enemy2.tscn"),
	preload("res://joc-ma/scenes/enemy3.tscn"),
	preload("res://joc-ma/scenes/enemy.tscn"),
	preload("res://joc-ma/scenes/enemy_4.tscn"),
	preload("res://joc-ma/scenes/enemy_5.tscn"),
	preload("res://joc-ma/scenes/diver_enemy.tscn")
]


@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var enemy_nonlethal = $enemy_nonlethal
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen
@onready var pb = $ParallaxBackground

@onready var laser_sound = $SFX/LaserSound
@onready var hit_sound = $SFX/HitSound
@onready var explode_sound = $SFX/ExplodeSound
@onready var explain_sound= $SFX/Explain
@onready var ai_castigat=$SFX/AiCastigat
@onready var ai_pierdut=$SFX/AiPierdut
var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
var high_score

var scroll_speed = 50

func _ready():
	timer.stop()  # Asigură-te că timer-ul este oprit inițial
	explain_sound.play()
	explain_sound.finished.connect(_on_explain_finished)
func _on_explain_finished() -> void:
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file!=null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	
	score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)
	

	print("Number of enemy scenes:", enemy_scenes.size())
	timer.start() 

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	if timer.wait_time > 0.5:
		timer.wait_time -= delta*0.005
	elif timer.wait_time < 0.5:
		timer.wait_time = 0.5
	
	pb.scroll_offset.y += delta*scroll_speed
	if pb.scroll_offset.y >= 960:
		pb.scroll_offset.y = 0

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	laser_sound.play()

func _on_enemy_spawn_timer_timeout():
	print("Number of enemy scenes:", enemy_scenes.size())
	if enemy_scenes.size() > 0:
		var e = enemy_scenes.pick_random().instantiate()
		print("Instantiated enemy:", e.name)  # Verifică dacă este instanțiat corect
		e.global_position = Vector2(randf_range(50, 500), -50)
		
		if(e.name.find("Fara")!=-1):
			print("am intrat aici ")
			e.killedwrong.connect(_on_enemy_killed_wrong)
			e.add_to_group("enemy_nonlethal")
		else:
			e.killed.connect(_on_enemy_killed)
			
		e.hit.connect(_on_enemy_hit)
		enemy_container.add_child(e)
		#print("enemy_nonlethal:", enemy_nonlethal)

		#if "Fara" in e.name:
		#await get_tree().create_timer(0.1).timeout
	
		
		#print("Added test enemy. Children count:", enemy_nonlethal.get_child_count())


		#print(enemy_container.get_child_count())
		#print("Number of children in enemy_nonlethal:", enemy_nonlethal.get_child_count())

	else:
		print("No enemy scenes available.")
func _on_enemy_killed_wrong(points):
	hit_sound.play()
	score -= points
	if score > high_score:
		high_score = score
	if(score==-300):
		_on_player_killed()

func _on_enemy_killed(points):
	hit_sound.play()
	score += points
	if score > high_score:
		high_score = score
	if(score>=1200):
		_on_player_killed()

func _on_enemy_hit():
	hit_sound.play()

func _on_player_killed():
	explode_sound.play()
	gos.set_score(score)
	gos.set_high_score(high_score)
	if(score<=-300):
		ai_pierdut.play()
	else:
		ai_castigat.play()
	save_game()
	await get_tree().create_timer(1.5).timeout
	gos.visible = true
