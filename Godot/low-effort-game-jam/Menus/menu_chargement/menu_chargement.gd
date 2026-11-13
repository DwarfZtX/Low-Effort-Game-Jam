extends Control

@onready var progress_bar = $ProgressBar
@export var next_sceen_path: String = ""
@export var progress: Array[float] = []

func _ready():
	next_sceen_path = Global.scene_to_load
	ResourceLoader.load_threaded_request(next_sceen_path)
	$Label.text = [
		"Death is bad for your life.",
		" 'Yeah.' [font_size=10][i]The Dev[/i], 2026.",
		"Do It ! Just Do It !",
		"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH",
		"Nuh Uh",
		"Stop being handsome, you'll make the game crash ;)",
		"Dementia ? Dementia ?",
		"Touch grass",
		"Apparently Cats Are Bots",
	].pick_random()

func _process(_delta):
	var status = ResourceLoader.load_threaded_get_status(next_sceen_path, progress)
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var pct = progress[0] * 100
			progress_bar.value = pct
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene = ResourceLoader.load_threaded_get(next_sceen_path)
			get_tree().change_scene_to_packed(scene)
			SignalBus.new_scene_loaded.emit()
