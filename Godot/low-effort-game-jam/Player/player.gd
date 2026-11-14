extends CharacterBody3D

const SPEED = 4.0
const SPRINT = 15.0
const JUMP_VELOCITY = 6.5
const SENSI = 0.002
const SENSI_SCOPE_DIVIDER = 5
const SENSI_CONTROLLER_FACTOR = 23
const JOYSTICK_DEADZONE = 0.2

@onready var head = $head
@onready var rayInteract = $head/headAnchor/RayInteract
@onready var handPackage = $head/headAnchor/HandPackage
@onready var handWeapon = $head/headAnchor/HandWeapon
@onready var DashTimer = $dashTimer
@onready var DashLimiter = $dashLimiter
@onready var ChromaMesh = $head/headAnchor/Camera3D/meshChroma

var speed
var gravity = 10
var mouse_input = Vector2.ZERO
var instance

var bullet = preload("res://Misc/projectiles/projectile.tscn")

# variable de gestion de la vie
@export var life = 200
@export var max_life = 200

@export var exhaustion = 0

var colis 

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
	
	## interact
	
	if rayInteract.is_colliding() and rayInteract.get_collider() != null:
		match rayInteract.get_collider().interactState:
			"GetColis":
				SignalBus.interactLabelShow.emit("[E] get the Package")
			"Desactivated":
				pass
			"GetFood":
				SignalBus.interactLabelShow.emit("[E] Get Food (32 C$)")
		
		
		if Input.is_action_just_pressed("interact"):
			match rayInteract.get_collider().interactState:
				"GetColis":
					if colis == null:
						colis = rayInteract.get_collider().getTheColis()
						change_colis()
				"GetFood":
					Game.CrouskiDollars-=32
					life+=50
					SignalBus.changeInLife.emit(life,max_life)
	else :
		SignalBus.interactLabelShow.emit("")
	
	
	## shoot
	if Input.is_action_just_pressed("click gauche"):
		instance = bullet.instantiate()
		instance.position = $head/headAnchor/HandWeapon/MeshPistol/MarkerProj.global_position
		instance.transform.basis = $head/headAnchor/HandWeapon/MeshPistol/MarkerProj.global_transform.basis
		
		instance.transform.basis *= Basis(Vector3(1,0,0), deg_to_rad(randf_range(-5,5))) * Basis(Vector3(0,1,0), deg_to_rad(randf_range(-5,5)))
		
		instance.degat = 50
		get_parent().add_child(instance)
		head.apply_recoil(5)
		$Node/AudioShoot.pitch_scale = randf_range(0.95,1.05)
		$Node/AudioShoot.play()
	
	
	if Input.is_action_just_pressed("click droit") and DashLimiter.is_stopped():
		DashTimer.start()
		if !Game.unlimitedDash:
			DashLimiter.start()

	## deplacement
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	if Input.is_action_pressed("sprint"):
		if !$Node/AudioCourse.playing:
			$Node/AudioCourse.play()
		speed = SPRINT
	else :
		speed = SPEED
	
	
	if Input.is_action_just_pressed("saut") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	var input_dir = Input.get_vector("gauche", "droite", "haut", "bas")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if !DashTimer.is_stopped():
		direction *=5
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else :
			velocity.x /= 1.2
			velocity.z /= 1.2
	else :
		if direction and !DashTimer.is_stopped():
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		if direction :
			velocity.x = lerp(velocity.x,direction.x * speed,delta * 2.0)
			velocity.z = lerp(velocity.z,direction.z * speed,delta * 2.0)
	
	move_and_slide()
	
	head.head_bob(velocity.length(),delta)
	head.cam_tilt(input_dir.x,delta)
	
	$head/headAnchor/Camera3D.fov = lerp($head/headAnchor/Camera3D.fov,75+(velocity.length()/2),0.1)
	
	var tempo 
	if DashTimer.is_stopped():
		tempo = lerp(ChromaMesh.mesh.material.get_shader_parameter('aberration_strength'),0.0,0.1)
	else:
		tempo = lerp(ChromaMesh.mesh.material.get_shader_parameter('aberration_strength'),velocity.length()/1000,0.1)
	ChromaMesh.mesh.material.set_shader_parameter('aberration_strength', tempo)
	

	var controller_cam_rot : Vector2 = Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))
	if controller_cam_rot.length() > JOYSTICK_DEADZONE:
		var sensi = SENSI*SENSI_CONTROLLER_FACTOR
		rotate_y(-controller_cam_rot.x * sensi)
		head.rotate_x(-controller_cam_rot.y * sensi)
		head.rotation.x = clamp(head.rotation.x ,-PI/2 ,PI/2)

func hit(damage:int):
	life-=damage
	SignalBus.changeInLife.emit(life,max_life)
	head.camera_shake()
	if life <= 0:
		SignalBus.game_death.emit()


func change_colis():
	for mesh in handPackage.get_children():
		mesh.hide()
	if colis != null:
		handPackage.find_child('Mesh'+colis).show()



func post_colis():
	if colis:
		colis = null
		change_colis()
		SignalBus.delivery_completed.emit(global_position)
