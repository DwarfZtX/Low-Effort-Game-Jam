extends Node3D

@export var zoneActif = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if zoneActif:
		pass
	
