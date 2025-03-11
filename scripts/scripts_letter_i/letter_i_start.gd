extends Node2D

var i_mic_coș
var i_mare_coș
var non_i_coș
var imagini = []
var imagine_curentă
var iepuraș
var punctaj = 0
var label
var buton_iesire
var artificii
var stea
var misiune 
var corect 
var gresit 
var iesi 
var felicitari 

var coordonate = [
	Vector2(379, 318),    
	Vector2(430, 360), 
	Vector2(480, 390),  
	Vector2(500, 415), 
	Vector2(530, 420),  
	Vector2(580, 470),   
	Vector2(650, 400), 
	Vector2(670, 450),  
	Vector2(700, 490), 
	Vector2(730, 470), 
	Vector2(780, 460),   
	Vector2(800, 500), 
	Vector2(840, 520),  
	Vector2(880, 550), 
	Vector2(900, 600), 
]


var index_coord = 0 
var image_selected = false 
var imagine_sprite = Sprite2D.new()
func _ready():
	i_mic_coș = $cos_i_mic
	i_mare_coș = $cos_i_mare
	non_i_coș = $cos_non_i
	artificii=$artificii
	buton_iesire=$Button
	label=$Label
	stea=$stea
	
	misiune=$misiunea
	corect=$corect
	gresit=$gresit
	iesi=$iesi
	felicitari=$felicitari
	
	imagini = [
		"res://assets/images/letter_i_scene/imagini_cu_i/img1_mare.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img2_non.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img3_mic.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img4_non.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img5_mic.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img6_non.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img7_non.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img8_non.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img9_mic.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img10_non.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img11_mare.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img12_non.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img13_mare.png", 
		"res://assets/images/letter_i_scene/imagini_cu_i/img14_non.png"
	]
	
	imagine_curentă = imagini[0]
	spawn_imagine(imagine_curentă)
	
	iepuraș = $Sprite2D
	iepuraș.position = coordonate[index_coord]   
	play_sound(misiune) 


func play_sound(soundNode: AudioStreamPlayer) -> void:
	soundNode.play()

func spawn_imagine(imagine):
	artificii.emitting = true
	imagine_curentă=imagine
	imagine_sprite.queue_free()
	imagine_sprite = Sprite2D.new()
	imagine_sprite.texture = load(imagine)
	add_child(imagine_sprite)
	
	var textura = imagine_sprite.texture
	if textura:
		var original_size = textura.get_size()
		var target_size = Vector2(200, 200)
		imagine_sprite.scale = target_size / original_size
	
	imagine_sprite.position = Vector2(656.375, 229.5)  # Poziționează imaginea pe ecran
	imagine_sprite.name = imagine.split("/")[6]  
	print( imagine_sprite.name)


func _on_cos_pressed(coș):
	if image_selected:
		return  # Nu face nimic dacă deja am selectat o imagine
	
	if $misiunea.is_playing():
		return

	var imagine_finisata = imagine_curentă.split("/")[6]
	print(imagine_finisata)
	var denumire_cos = coș.name  # Coșul care a fost apăsat are denumirea lui

	if imagine_finisata.begins_with("img") and imagine_finisata.ends_with("mic.png") and denumire_cos == "cos_i_mic":
		punctaj += 1
		print("Corect! Punctaj: " + str(punctaj))
		play_sound(corect)
		move_to_next_step()
	elif imagine_finisata.begins_with("img") and imagine_finisata.ends_with("mare.png") and denumire_cos == "cos_i_mare":
		punctaj += 1
		print("Corect! Punctaj: " + str(punctaj))
		play_sound(corect)
		move_to_next_step()
	elif imagine_finisata.begins_with("img") and imagine_finisata.ends_with("non.png") and denumire_cos == "cos_non_i":
		punctaj += 1
		print("Corect! Punctaj: " + str(punctaj))
		play_sound(corect)
		move_to_next_step()
	else:
		play_sound(gresit)
		print("Mai încearcă!")

func move_to_next_step():
	image_selected = true  
	if index_coord >= imagini.size() - 1:
		felicitari_fct()
		return

	index_coord += 1
	var coord = coordonate[index_coord]
	iepuraș.position = coord

	spawn_imagine(imagini[index_coord])
	image_selected = false

func felicitari_fct():
	await ($corect.finished)
	play_sound(felicitari)
	imagine_sprite.queue_free()
	label.visible = true
	buton_iesire.visible = true
	stea.visible=false
	buton_iesire.connect("pressed", _intoarcere_la_inceput)

func _intoarcere_la_inceput():
	get_tree().change_scene_to_file("res://scenes/scenes_letter_i/letter_i_start_int.tscn")


func _on_button_mare_pressed() -> void:
	_on_cos_pressed(i_mare_coș)

func _on_button_mic_pressed() -> void:
	_on_cos_pressed(i_mic_coș)

func _on_button_non_pressed() -> void:
	_on_cos_pressed(non_i_coș)


func _on_button_mouse_entered() -> void:
	play_sound(iesi)
