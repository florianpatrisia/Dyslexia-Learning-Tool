extends Control

@onready var cuvantLabel: Label = $VBoxContainer/Cuvant
@onready var silabeBox: HBoxContainer = $VBoxContainer/Silabe
var temaLabel := preload("res://assets/styles/label2.tres")
var cuvinte := {
	"Ienupăr":['Ie','nu','păr'],
	"Iepure":['Ie','pu','re'],
	"Ieșire":['Ie','și','re'],
	"Bătaie":['Bă','ta','ie'],
	'Fluiere':['Flu','ie','re'],
	'Iedului':['Ie','du','lui'],
	'Voievod':['Vo','ie','vod'],
	}

var cuvinteStack = []

func _ready() -> void:
	for cuv in cuvinte:
		var copie = cuvinte[cuv].duplicate()
		cuvinteStack.append(cuv)
		cuvinte[cuv].shuffle()
		while cuvinte[cuv].hash() == copie.hash():
			cuvinte[cuv].shuffle()
			
func _on_ie_mic_mouse_entered() -> void:
	if $IE.is_playing():
		return
	Game.play_sound($ie)


func _on_ie_mare_mouse_entered() -> void:
	if $ie.is_playing():
		return
	Game.play_sound($IE)


func _on_indicatii_finished() -> void:
	$Hint.visible = true
	var cuvantActual = cuvinteStack.pop_front()
	var silabe = cuvinte[cuvantActual]
	cuvantLabel.text = cuvantActual
	for silaba in silabe:
		var silabaLabel = Label.new()
		silabaLabel.text = silaba
		silabaLabel.add_theme_stylebox_override('normal',temaLabel)
		silabeBox.add_child(silabaLabel) 
	$VBoxContainer.visible = true
	
	
func _get_drag_data(at_position: Vector2) -> Variant:
	for child in silabeBox.get_children():
		if child.get_global_rect().has_point(at_position):
			var preview = child.duplicate()  
			set_drag_preview(preview)
			return {"source": child, "text": child.text}
	return null

func _can_drop_data(position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and "source" in data and "text" in data

func _drop_data(position: Vector2, data: Variant) -> void:
	if _can_drop_data(position, data):
		var global_pos = get_global_mouse_position()
		for child in silabeBox.get_children():
			if child.get_global_rect().has_point(global_pos):
				var dropped_label_text = data["text"]
				data["source"].text = child.text
				child.text = dropped_label_text  
				check_cuvant_corect()
				
func check_cuvant_corect() -> void:
	var text = ''
	var silabe = silabeBox.get_children()
	for silaba in silabe:
		text += silaba.text
	if text == cuvantLabel.text:
		$Success.play()
		for silaba in silabe:
			silaba.queue_free()
		if cuvinteStack.is_empty():
			$VBoxContainer.visible = false
			$Final.play()
			$Hint.visible = false
			return
		var cuvantActual = cuvinteStack.pop_front()
		silabe = cuvinte[cuvantActual]
		cuvantLabel.text = cuvantActual
		for silaba in silabe:
			var silabaLabel = Label.new()
			silabaLabel.text = silaba
			silabaLabel.add_theme_stylebox_override('normal',temaLabel)
			silabeBox.add_child(silabaLabel) 
		

func _on_final_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/silabe.tscn")


func _on_hint_mouse_entered() -> void:
	$Hint_Silabe.visible = true
	await get_tree().create_timer(4).timeout 
	$Hint_Silabe.visible = false
	
