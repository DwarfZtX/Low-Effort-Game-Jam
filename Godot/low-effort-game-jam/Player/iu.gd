extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.interactLabelShow.connect(InteractLabelshow)



func InteractLabelshow(newText):
	$interactLabel.text = newText
