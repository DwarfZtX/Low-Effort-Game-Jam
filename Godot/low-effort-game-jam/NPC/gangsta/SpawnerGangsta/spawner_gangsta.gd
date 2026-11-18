extends Node3D

var gangsta = preload("res://NPC/gangsta/NPCgangstaBase/npc_gangsta.tscn")
var instance
var triggered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if $GangstaList.get_child_count() < 3:
		instance = gangsta.instantiate()
		instance.position = Vector3(randi_range(-5,5),2,randi_range(-5,5))
		instance.rotation.y = randi() * 2 * PI
		instance.trigger = triggered
		$GangstaList.add_child(instance)


func _on_area_gang_body_entered(_body):
	#trigger tout les membre du gang
	triggered = true
	for gangstaBody in $GangstaList.get_children():
		gangstaBody.trigger = true
