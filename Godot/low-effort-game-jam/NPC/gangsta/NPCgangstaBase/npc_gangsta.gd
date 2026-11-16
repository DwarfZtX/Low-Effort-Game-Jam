extends CharacterBody3D


@onready var nav_agent = $NavigationAgent3D


var default

var targets_list = []
var actual_target
var target
var next_nav_point
var avoidance_buffer

var gravity = 10

@export_enum("idle","falling","walking","attacking") var state : String


const SPEED = 5.0
const TURN_SPEED = 1.8

var PROXIMITY_RANGE = 1
var ATTACK_RANGE = 2
var DAMAGE = 30

@export var life = 80



func _physics_process(delta):
	
	
	
	# remise a zéro de la cible 
	target = false
	# si a portée d'attaque on attaque
	if actual_target != null and global_position.distance_to(actual_target.global_position) <= ATTACK_RANGE: 
		state = "attacking"
		target = actual_target
	# sinon si a porté d'engagement max on bouge vers la cible
	elif actual_target != null and global_position.distance_to(actual_target.global_position) <= 20: 
		state = "walking"
		target = actual_target
	# sinon, on ne bouge pas
	else :
		state = "idle"
	
	if not is_on_floor():
		state = "falling"
	
	
	
	match state:
		"idle":
			
			#velocity = Vector3.ZERO
			velocity = velocity/1.2
		"falling":
			velocity += get_gravity() * delta
		"walking":
			
			# TODO ajouter une esquive de se qu'il y a devant
			
			# réduit le nbr d'appel a get_next_path_position() qui est extensif sur de grande période et quantité
			if $TimerNav.is_stopped():
				$TimerNav.start()
				avoidance_buffer = compute_avoidance()
				nav_agent.set_target_position(target.global_transform.origin)
				next_nav_point = nav_agent.get_next_path_position()
			
			
			var next_nav_point_vector = Vector3(next_nav_point.x, global_position.y, next_nav_point.z)
			var direction = ((next_nav_point_vector - global_transform.origin)+(avoidance_buffer*5)).normalized()
			
			
			velocity.x = lerp(velocity.x,direction.x * SPEED,delta * 2.0)
			velocity.z = lerp(velocity.z,direction.z * SPEED,delta * 2.0)
			
			
			
			global_transform.basis = global_transform.basis.slerp(Basis.looking_at(direction, Vector3.UP), TURN_SPEED * delta)
		"attacking":
			velocity = velocity/1.2
			var direction = (Vector3(target.global_position.x,global_position.y,target.global_position.z) - global_position).normalized()
			global_transform.basis = global_transform.basis.slerp(Basis.looking_at(direction, Vector3.UP), TURN_SPEED * delta)
			if $TimerAtt.is_stopped():
				attack()
				$TimerAtt.start()
			
	move_and_slide()



func attack():
	$TimerAtt.start()
	for body in $AreaAtt.get_overlapping_bodies():
		if body != self:
			body.hit(DAMAGE)



func hit(degat):
	life-= degat
	if life<= 0:
		queue_free()


func _on_area_detection_body_entered(body: Node3D) -> void:
	targets_list.append(body)


func _on_area_detection_body_exited(body: Node3D) -> void:
	targets_list.erase(body)


func _on_timer_target_timeout() -> void:
	# Sert a redéfinir la cible actuel toutes les X secondes
	# cherche la cible la plus proche
	var new_actual_target = null
	for new_target in targets_list:
		if new_actual_target == null or global_position.distance_to(new_actual_target.global_position)> global_position.distance_to(new_target.global_position):
			new_actual_target = new_target
	actual_target = new_actual_target


func compute_avoidance() -> Vector3:
	var avoidance = Vector3.ZERO
	for ray in $RayList.get_children():
		if ray.is_colliding():
			var dist = ray.global_position.distance_to(ray.get_collision_point())
			avoidance += ray.get_collision_normal() / max(dist, 0.1)
	return avoidance
