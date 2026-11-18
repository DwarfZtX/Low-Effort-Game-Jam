extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.interactLabelShow.connect(InteractLabelshow)
	SignalBus.changeInLife.connect(changeLifeBar)
	SignalBus.changeValueDollars.connect(changeDollars)

func _process(delta: float) -> void:
	if Game.CrouskiDollars<0:
		$dollarsPanel/AnimationPlayer.play("danger_dollars")
	else:
		$dollarsPanel/AnimationPlayer.play("RESET")

func changeDollars():
	$dollarsPanel/MarginContainer/dollarsLabel.text = str(Game.CrouskiDollars)+" Crouskidollars"



func InteractLabelshow(newText):
	$interactLabel.text = newText


func changeLifeBar(life,max_life):
	$lifebar.max_value = max_life
	$lifebar.value = life
