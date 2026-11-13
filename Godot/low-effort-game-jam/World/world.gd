extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Dialogic.start("StartDialogue")
	await get_tree().create_timer(2.0).timeout
	SignalBus.delivery_completed.emit($Player.global_position)
