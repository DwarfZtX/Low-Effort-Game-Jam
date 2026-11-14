extends Node3D

@onready var headAnchor = $headAnchor
@onready var camera_node = $headAnchor/Camera3D
@onready var weapon_holder = $headAnchor/HandWeapon


# Bobbing
var head_bob_amount = 0.5

var headAnchorDefaultPos = Vector3(0.0,0.0,0.0)
var headAnchorDefaultRot = Vector3(0.0,0.0,0.0)

# Tilting
var cam_rotation_amount = 0.05

# recoil
var recoil_accumulator = 0.0
var recoil_treshold = 18.0
var recoil_diminutor = 0.08
var recoil_randomizer = 0.0
var recoil_randomizer_amount = 0.0
var recoil_randomizer_limiter = 0.4





var headAnchorRotationTilt = Vector3.ZERO
var headAnchorPositionBob = Vector3.ZERO
var headAnchorRotationRecoil = Vector3.ZERO

var weaponHolderPositionRecoil = Vector3.ZERO

func _physics_process(_delta: float) -> void:
	
	recoil_accumulator = lerp(recoil_accumulator, 0.0, recoil_diminutor)
	headAnchorRotationRecoil.x = lerp(headAnchorRotationRecoil.x, recoil_accumulator/50,0.3)
	weaponHolderPositionRecoil.z = lerp(weaponHolderPositionRecoil.z, recoil_accumulator/100,0.3)
	
	
	headAnchor.position = headAnchorPositionBob
	headAnchor.rotation = headAnchorRotationTilt  + headAnchorRotationRecoil
	
	weapon_holder.position = weaponHolderPositionRecoil


func apply_recoil(recoil):
	if recoil_accumulator + recoil > recoil_treshold:
		recoil_accumulator += recoil/abs(recoil_treshold-(recoil_accumulator+recoil))
	else :
		recoil_accumulator += recoil
	recoil_accumulator = clamp(recoil_accumulator,0.0,30.0)
	recoil_randomizer+=recoil_randomizer_amount
	recoil_randomizer = clamp(recoil_randomizer,-recoil_randomizer_limiter,recoil_randomizer_limiter)
	recoil_randomizer_amount = randf_range(-0.1,0.1)
	get_parent().rotation_degrees.y += recoil_randomizer


func cam_tilt(input_x,delta):
	if self:
		headAnchorRotationTilt.z = lerp(headAnchorRotationTilt.z , -input_x * cam_rotation_amount , 10* delta)


func head_bob(vel:float,delta):
	if headAnchor:
		if vel >0.5 and get_parent().is_on_floor():
			vel = clamp(vel,0.5,15)
			var bob_amount = 0.02 * vel
			var bob_freq = 0.01
			headAnchorPositionBob.y = lerp(headAnchorPositionBob.y, headAnchorDefaultPos.y + sin(Time.get_ticks_msec() * bob_freq) * bob_amount , 10*delta)
			headAnchorPositionBob.x = lerp(headAnchorPositionBob.x, headAnchorDefaultPos.x + sin(Time.get_ticks_msec() * bob_freq *0.5 ) * bob_amount , 10*delta)
		else :
			headAnchorPositionBob.y = lerp(headAnchorPositionBob.y, headAnchorDefaultPos.y,10*delta)
			headAnchorPositionBob.x = lerp(headAnchorPositionBob.x, headAnchorDefaultPos.x,10*delta)



func camera_shake():
	var shake_power = 0.5
	var tw = get_tree().create_tween()
	tw.tween_property(camera_node,"position",Vector3(randf()*shake_power,randf()*shake_power,randf()*shake_power),0.05)
	tw.tween_property(camera_node,"position",Vector3(randf()*shake_power,randf()*shake_power,randf()*shake_power),0.05)
	tw.tween_property(camera_node,"position",Vector3(randf()*shake_power,randf()*shake_power,randf()*shake_power),0.05)
	tw.tween_property(camera_node,"position",Vector3.ZERO,0.1)
