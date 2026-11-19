extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.interactLabelShow.connect(InteractLabelshow)
	SignalBus.changeInLife.connect(changeLifeBar)
	SignalBus.changeValueDollars.connect(changeDollars)
	SignalBus.police_trigger.connect(changepoliceAffichage)

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

func changepoliceAffichage():
	var value = log( Game.carExploded +Game.copKill + Game.gangKill + Game.residentKill)
	#print(value)
	if value <= 0:
		
		$policePanel.hide()
	else :
		
		$policePanel.show()
		if value <= 3:
			if $policePanel.theme_type_variation != "test":
				var shake_power = 20
				var tw = get_tree().create_tween()
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5,20),0.1)
			$policePanel/MarginContainer/Label.text = "Researched by the police"
			$policePanel.theme_type_variation = "test"
		elif value <= 4:
			if $policePanel.theme_type_variation != "test2":
				var shake_power = 20
				var tw = get_tree().create_tween()
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5,20),0.1)
			$policePanel/MarginContainer/Label.text = "Dead or Alive"
			$policePanel.theme_type_variation = "test2"
		else :
			if $policePanel.theme_type_variation != "test3":
				var shake_power = 20
				var tw = get_tree().create_tween()
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5+randf()*shake_power,20+randf()*shake_power),0.05)
				tw.tween_property($policePanel,"position",Vector2(438.5,20),0.1)
			$policePanel/MarginContainer/Label.text = "Tank Deployed"
			$policePanel.theme_type_variation = "test3"
