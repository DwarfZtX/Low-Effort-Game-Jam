extends CharacterBody3D


@export_enum("idle","scared","dancing") var state = "idle"

var life = 80


func _physics_process(delta: float) -> void:
	match state:
		"idle":
			pass
		"scared":
			pass
		"dancing":
			pass







func hit(degat):
	life-= degat
	state = "scared"
	if life<= 0:
		queue_free()
