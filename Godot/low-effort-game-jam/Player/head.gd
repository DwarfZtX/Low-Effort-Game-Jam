extends Node3D

@onready var headAnchor = $headAnchor
@onready var camera_node = $headAnchor/Camera3D


# Bobbing
var head_bob_amount = 0.5

var headAnchorDefaultPos = Vector3(0.0,0.0,0.0)
var headAnchorDefaultRot = Vector3(0.0,0.0,0.0)

# Tilting
var cam_rotation_amount = 0.05

var headAnchorRotationTilt = Vector3.ZERO
var headAnchorPositionBob = Vector3.ZERO


func _physics_process(_delta: float) -> void:
	headAnchor.position = headAnchorPositionBob
	headAnchor.rotation = headAnchorRotationTilt 





func cam_tilt(input_x,delta):
	if self:
		headAnchorRotationTilt.z = lerp(headAnchorRotationTilt.z , -input_x * cam_rotation_amount , 10* delta)


func head_bob(vel:float,delta):
	if headAnchor:
		if vel >0.5 and get_parent().is_on_floor():
			var bob_amount = 0.02 * vel
			var bob_freq = 0.01
			headAnchorPositionBob.y = lerp(headAnchorPositionBob.y, headAnchorDefaultPos.y + sin(Time.get_ticks_msec() * bob_freq) * bob_amount , 10*delta)
			headAnchorPositionBob.x = lerp(headAnchorPositionBob.x, headAnchorDefaultPos.x + sin(Time.get_ticks_msec() * bob_freq *0.5 ) * bob_amount , 10*delta)
		else :
			headAnchorPositionBob.y = lerp(headAnchorPositionBob.y, headAnchorDefaultPos.y,10*delta)
			headAnchorPositionBob.x = lerp(headAnchorPositionBob.x, headAnchorDefaultPos.x,10*delta)



func camera_shake():
	var shake_power = 0.2
	var tw = get_tree().create_tween()
	tw.tween_property(camera_node,"position",Vector3(randf()*shake_power,randf()*shake_power,randf()*shake_power),0.05)
	tw.tween_property(camera_node,"position",Vector3(randf()*shake_power,randf()*shake_power,randf()*shake_power),0.05)
	tw.tween_property(camera_node,"position",Vector3(randf()*shake_power,randf()*shake_power,randf()*shake_power),0.05)
	tw.tween_property(camera_node,"position",Vector3.ZERO,0.1)
