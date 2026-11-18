extends RigidBody3D


@export_enum("Desactivated","GetColis") var interactState = "GetColis"


func _ready() -> void:
	rotation.x = randi()*2*PI
	rotation.y = randi()*2*PI
	rotation.z = randi()*2*PI

func getTheColis():
	queue_free()
	return "Test"
