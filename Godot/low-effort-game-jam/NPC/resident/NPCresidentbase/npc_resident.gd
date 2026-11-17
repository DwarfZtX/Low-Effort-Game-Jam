extends CharacterBody3D


@export_enum("idle","scared","dancing") var state = "idle"

var life = 80
var danceAnim

func _ready():
	danceAnim = ["dance1","dance2","dance3"].pick_random()

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity() * delta
	match state:
		"idle":
			$p2/AnimationPlayer.play("idle")
		"scared":
			$p2/AnimationPlayer.play("fear")
		"dancing":
			$p2/AnimationPlayer.play(danceAnim)
	move_and_slide()




func dance():
	if state != "dancing":
		state = "dancing"
		$TimerIdle.start()

func fear():
	if state != "scared":
		state = "scared"
		$TimerIdle.start()

func hit(degat):
	life-= degat
	print(life)
	if life<= 0:
		queue_free()
	if state != "scared":
		state = "scared"
		$TimerIdle.start()


func _on_timer_idle_timeout():
	state = "idle"
