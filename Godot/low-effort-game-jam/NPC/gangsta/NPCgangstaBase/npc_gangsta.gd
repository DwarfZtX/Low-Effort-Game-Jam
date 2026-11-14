extends CharacterBody3D


@onready var nav_agent = $NavigationAgent3D


var default

var targets_list = []
var actual_target
var target
var next_nav_point

var gravity = 10

@export_enum("idle","falling","walking","attacking") var state : String


const SPEED = 5.0
const TURN_SPEED = 1.8

var PROXIMITY_RANGE = 1
var ATTACK_RANGE = 2

@export var life = 80



func attack():
	for body in $AreaAtt.get_overlapping_bodies():
		if body != self:
			body.hit(weapon.damage)



func hit(degat):
	life-= degat
	if life<= 0:
		queue_free()
