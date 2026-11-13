extends Node3D

## code de projectile Universel
## on peut presque tout modifier

@onready var ray = $RayCast3D
@onready var rayhit = $RayCast3D2
@onready var mesh = $mesh

@export_group("Speed")
@export var speed = 35

@export_group("Bounce")
@export var ifNotBounce = true #true = ne rebondie pas , false = rebondie
@export var bounceChance = 10 # plus c'est grand moins il y a de chance
@export var bounce = false 

@export_group("Gravity")
@export var affectedByGravity = false
@export var grav = 0.02
var grav_acc = 0 

@export_group("Damage")
@export var degat = 5
@export var ifExplosion = false
#@export var knockbackForce = 5

@export var particle: bool = false

var destroy = false # utilisé pour ne pas déplacer le proj quand il a touché

func _process(delta):
	#si le proj est détruit on ne fait rien (pour ne pas le déplacer)
	if destroy:
		return
	
	## déplacement
	var move_vec = transform.basis * Vector3(0,0,-speed) * delta
	
	if rayhit.is_colliding():
		if rayhit.get_collider() != null:
			rayhit.get_collider().hit(degat)
	
	# si collision
	if ray.is_colliding():
		#si bounce déja fait ou qui ne passe pas
		if (randi_range(1,bounceChance)!=1 or ifNotBounce) or bounce != false:
			destroy = true
			if particle:
				$GPUParticles3D.emitting = true
			mesh.hide()
			if ifExplosion:
				explosion()
			else :
				await get_tree().create_timer(1.0).timeout
				queue_free()
		# si bounce
		else :
			bounce = true
			affectedByGravity = true
			var normal = ray.get_collision_normal()
			var direction = move_vec.normalized()
			var reflected = direction - 2.0 * direction.dot(normal) * normal
			
			look_at(global_position + reflected, Vector3.UP)
			
			global_position += normal*0.1
			move_vec = transform.basis * Vector3(0,0,-speed) * delta
	
	global_position += move_vec
	
	# si gravité
	if affectedByGravity:
		grav_acc-=grav *delta
		var direction = Vector3(0,grav_acc,0)
		# petit probleme : W 0:01:54:658   projectile.gd:50 @ _process(): Target and up vectors are colinear. 
		#This is not advised as it may cause unwanted rotation around local Z axis.
		var target = global_position + move_vec + direction
		var up
		if abs((target-global_position).normalized().dot(Vector3.UP)) > 0.999 : up = Vector3.FORWARD 
		else : up = Vector3.UP
		look_at(target, up)


## détruit le projectile si il a passé plus de 10 secopnde en l'air sans rien toucher, le fait exploser si il peut
func _on_timer_timeout() -> void:
	if ifExplosion:
		explosion()
	else :
		queue_free()


## gestion de l'explosion
func explosion():
	$explosion/MeshInstance3D.show()
	## pour tout les corps on leurs inflige des dégats
	for body in $explosion/AreaExplosion.get_overlapping_bodies():
		#print(global_position.distance_to(body.global_position))
		body.hit(degat)
	await get_tree().create_timer(1.0).timeout
	queue_free() ## ajouté pour enlever l'explosion
		## partis pour la gestion du knockback
		#if !body.is_in_group("Batiment"):
			#var knock = global_position.direction_to(body.global_position) * knockbackForce
			#if body.is_in_group("IfKnock"):
				#body.knocked = true
			#knock.y += 3
			#body.velocity += knock
	#$explosion/AnimationPlayer.play("explosion")
#
#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#queue_free()
