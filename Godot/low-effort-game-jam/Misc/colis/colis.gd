extends RigidBody3D


@export_enum("Desactivated","GetColis") var interactState = "GetColis"




func getTheColis():
	queue_free()
	return "Test"
