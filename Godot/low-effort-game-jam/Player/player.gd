extends CharacterBody3D

const SPEED = 4.0
const SPRINT = 9.0
const JUMP_VELOCITY = 6.5
const SENSI = 0.002
const SENSI_SCOPE_DIVIDER = 5

@onready var head = $head
@onready var rayInteract = $head/headAnchor/RayInteract


var speed
var gravity = 10
var mouse_input = Vector2.ZERO
var instance

# variable de gestion de la vie
@export var life = 200
@export var max_life = 200


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	#rotation joueur et camera
	if event is InputEventMouseMotion :
		var sensi = SENSI
		#if head.is_scoping:
		#	sensi = SENSI / SENSI_SCOPE_DIVIDER
		rotate_y(-event.relative.x * sensi)
		head.rotate_x(-event.relative.y * sensi)
		head.rotation.x = clamp(head.rotation.x ,-PI/2 ,PI/2)
		mouse_input = event.relative




func _physics_process(delta: float) -> void:
	
	if rayInteract.is_colliding():
		pass
		if Input.is_action_just_pressed("interact"):
			match rayInteract.get_collider().interactState:
				"":
					pass
	else :
		pass
	
	
	
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT
	else :
		speed = SPEED
	
	
	if Input.is_action_just_pressed("saut") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	var input_dir = Input.get_vector("gauche", "droite", "haut", "bas")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else :
			velocity.x /= 1.2
			velocity.z /= 1.2
	else :
		if direction :
			velocity.x = lerp(velocity.x,direction.x * speed,delta * 2.0)
			velocity.z = lerp(velocity.z,direction.z * speed,delta * 2.0)
	
	move_and_slide()
	
	head.head_bob(velocity.length(),delta)
	head.cam_tilt(input_dir.x,delta)
	
