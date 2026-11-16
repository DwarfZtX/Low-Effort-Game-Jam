extends Control
@export_multiline var stat_game : String

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.game_death.connect(loseGame)


func loseGame():
	get_tree().paused = true
	show()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	stat_game = "
	Package delivered : %s
	
	Car destroyed : %s
	Resident Killed : %s
	Gang Member Killed : %s
	Police Officer Killed : %s
	"
	
	
	$PanelContainer/MarginContainer/VBoxContainer/RichTextLabel.text = stat_game % [Game.packageDelivered,Game.carExploded,Game.residentKill,Game.gangKill,Game.copKill]


func _on_b_menu_pressed():
	get_tree().paused = false
	Global.scene_to_load = "res://Menus/menu_princ/menu_princ.tscn"
	get_tree().change_scene_to_file("res://Menus/menu_chargement/menu_chargement.tscn")
