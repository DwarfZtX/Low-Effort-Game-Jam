extends Node3D

var colis = preload("res://Misc/colis/colis.tscn")
var instance

var zoneLivraison = null



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.delivery_completed.connect(create_new_delivery)


func create_new_delivery(posPlayer):
	var newZoneLivraison
	while newZoneLivraison == null or zoneLivraison == newZoneLivraison:
		newZoneLivraison = Game.listeZone.pick_random()
	zoneLivraison = newZoneLivraison
	zoneLivraison.changeZoneActivation(true)
	#Game.listeZone.pick_random().changeZoneActivation(true)
	
	
	instance = colis.instantiate()
	add_child(instance)
	instance.global_position = posPlayer+Vector3(randf_range(-2.0,2.0),2,randf_range(-2.0,2.0))
	
