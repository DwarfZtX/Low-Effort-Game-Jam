extends StaticBody3D

var life = 200





func hit(damage):
	if life<= 0: return
	life-=damage
	if life<=0:
		for body in $AreaDamage.get_overlapping_bodies():
			if body != self:
				body.hit(20)
		$AudioStreamPlayer3D.play()
		$GPUParticles3D.emitting = true
		$GPUParticles3D2.emitting = true
		await get_tree().create_timer(2.0).timeout
		queue_free()
