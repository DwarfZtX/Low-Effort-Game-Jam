extends Node3D

var cop = preload("res://NPC/cops/NPCcopsBase/npc_cop.tscn")



func _on_area_3d_body_entered(_body):
	$Timer.start()



func _on_timer_timeout():
	if $CopList.get_child_count() >= 3: return
	
	var value = log( Game.carExploded +Game.copKill + Game.gangKill + Game.residentKill)
	if  value >=0:
		var instance = cop.instantiate()
		instance.position =  Vector3(0,0,0)
		instance.rotation.y = randi() * 2 * PI
		$CopList.add_child(instance)


func _on_area_3d_body_exited(_body):
	$Timer.stop()
