extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("echap"):
		if visible:
			_on_b_resume_pressed()
		else:
			visible = true
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
			%B_resume.grab_focus()


func _on_b_resume_pressed() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false


func _on_b_menu_pressed() -> void:
	get_tree().paused = false
	Global.scene_to_load = "res://Menus/menu_princ/menu_princ.tscn"
	get_tree().change_scene_to_file("res://Menus/menu_chargement/menu_chargement.tscn")


func _on_b_desktop_pressed() -> void:
	get_tree().quit()
