extends StaticBody3D

var life = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func hit(damage):
	if life<= 0: return
	life-=damage
	if life<=0:
		for body in $AreaDamage.get_overlapping_bodies():
			if body != self:
				body.hit(20)
		$GPUParticles3D.emitting = true
		$GPUParticles3D2.emitting = true
		await get_tree().create_timer(2.0).timeout
		queue_free()
