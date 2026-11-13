extends Node3D

@export var zoneActif = false
@export_enum("Centre","Banlieux","Indus","Plaine") var typeZone : String  


func _ready() -> void:
	Game.listeZone.append(self)
	$MeshInstance3D.hide()


func changeZoneActivation(active: bool):
	zoneActif = active
	if zoneActif:
		$MeshInstance3D.show()
	else :
		$MeshInstance3D.hide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if zoneActif:
		body.post_colis()
		changeZoneActivation(false)
	
