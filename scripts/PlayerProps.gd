extends Node

var coins:int = 0 : set = _set_coins

func _set_coins(new_coins: int): 
	coins = new_coins
	GlobalSignals.emit_signal("on_coins_changed",new_coins)
