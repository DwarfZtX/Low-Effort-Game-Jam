extends Node

@export var CrouskiDollars : int = 50 :
	set(value):
		SignalBus.changeValueDollars.emit(value)
		CrouskiDollars = value

## TODO ajouter la pos des zone de livraisons
#@export var listeZone = {
	#"Banlieux":[
		#
	#]
#}

@export var listeZone = [
	
]



func reset_game_var():
	CrouskiDollars = 50
