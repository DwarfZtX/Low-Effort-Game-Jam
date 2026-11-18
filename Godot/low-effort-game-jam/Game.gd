extends Node

@export var CrouskiDollars : int = 50 :
	set(value):
		CrouskiDollars = value
		SignalBus.changeValueDollars.emit()

@export var player = null


@export var Ammo : int = 0
@export_enum("hand","PeterTurbo 4/20","Roubot 500","Vulkan Salamander","Jagatana") var weaponPlayer : String = "hand"
@export var weaponData = {
	"hand":{
		"price":0,
		"damage":25,
		"projectile":false,
		"attackAnim":"punch_r",
		"mesh":null
	},
	"PeterTurbo 4/20":{ # pistolet gros calibre
		"price":450,
		"damage":120,
		"projectile":true,
		"recoil":15,
		"dispertion":1,
		"magazine":1,
		"attackAnim":"shot-r",
		"mesh":"peterturbo",
		"speedAnim":1,
	},
	"Roubot 500":{ # pistolet basique
		"price":300,
		"damage":70,
		"projectile":true,
		"recoil":7,
		"dispertion":1,
		"magazine":8,
		"attackAnim":"shot-r",
		"mesh":"roubot",
		"speedAnim":2,
	},
	"Vulkan Salamander":{ # pistolet mitrailleur
		"price":375,
		"damage":25,
		"projectile":true,
		"recoil":3,
		"dispertion":2,
		"magazine":20,
		"attackAnim":"fastshot-r",
		"mesh":"vulkan",
		"speedAnim":3,
	},
	"Jagatana":{ # Katana
		"price":1000,
		"damage":50,
		"projectile":false,
		"attackAnim":"slash_r",
		"mesh":"jagatana"
	}
}


## TODO ajouter la pos des zone de livraisons
#@export var listeZone = {
	#"Banlieux":[
		#
	#]
#}

@export var listeZone = [
	
]

## inutilisé pour l'instant
@export_enum("package","delivery","waiting","free") var stateGame : String


@export_enum("Neutral","Reaserching") var statBanker : String = "Neutral"
@export_enum("Neutral","Reaserching") var statCop : String = "Neutral"
@export_enum("Neutral","Reaserching") var statGang : String = "Neutral"


# cheat
@export var unlimitedDash = false
@export var unlimitedAmmo = false
@export var unlimitedCash = false


# stat
@export var gangKill = 0
@export var copKill = 0
@export var residentKill = 0

@export var carExploded = 0
@export var packageDelivered = 0



func reset_game_var():
	CrouskiDollars = 50
	Ammo = 10
	
	
	unlimitedDash = false
	unlimitedAmmo = false
	unlimitedCash = false
	
	
	packageDelivered = 0
	carExploded = 0
	residentKill = 0
	copKill = 0
	gangKill = 0
	
	player = null
