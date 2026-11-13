extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED





func _on_b_play_pressed() -> void:
	Game.reset_game_var()
	Global.scene_to_load = "res://World/world.tscn"
	get_tree().change_scene_to_file("res://Menus/menu_chargement/menu_chargement.tscn")


func _on_b_credit_pressed() -> void:
	pass # Replace with function body.


func _on_b_quit_pressed() -> void:
	get_tree().quit()
