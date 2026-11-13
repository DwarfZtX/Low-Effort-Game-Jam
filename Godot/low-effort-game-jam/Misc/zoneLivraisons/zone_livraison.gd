extends Node3D

@export var zoneActif = false


func changeZoneActivation(active: bool):
	zoneActif = active
	if zoneActif:
		$MeshInstance3D.show()
	else :
		$MeshInstance3D.hide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if zoneActif:
		pass
	
