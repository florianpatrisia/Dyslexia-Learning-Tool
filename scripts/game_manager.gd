extends Node

var score = 0
@onready var score_label: Label = $ScoreLabel
var lives=3

func add_point():
	score+=1
	print(score)
	#score_label.text="You collected " + str(score) + " coins!"
