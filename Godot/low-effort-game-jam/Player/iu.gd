extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.interactLabelShow.connect(InteractLabelshow)
	SignalBus.changeInLife.connect(changeLifeBar)

func _process(delta: float) -> void:
	$dollarsLabel.text = str(Game.CrouskiDollars)+" Crouskidollars"



func InteractLabelshow(newText):
	$interactLabel.text = newText


func changeLifeBar(life,max_life):
	$lifebar.max_value = max_life
	$lifebar.value = life
