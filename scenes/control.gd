extends Control

var obiecte = ['Elan','Carne','Leu','Elefant','Albina','Pui','Gaina','Caine','Cal','Zebra']

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for obiect_name in obiecte:
		var panel_box = get_node(obiect_name)
		if panel_box and panel_box is PanelContainer:
			panel_box.visible = false
