extends Node

@export var CrouskiDollars : int = 50 :
	set(value):
		SignalBus.changeValueDollars.emit(value)
		CrouskiDollars = value


@export var Ammo : int = 0
@export_enum("hand","PeterTurbo 4/20","Roubot 500","Vulkan Salamander","Jagatana") var weaponPlayer : String = "Roubot 500"
@export var weaponData = {
	"hand":{
		"price":0,
		"damage":25,
		"projectile":false
	},
	"PeterTurbo 4/20":{ # pistolet gros calibre
		"price":450,
		"damage":120,
		"projectile":true,
		"recoil":15,
		"dispertion":2,
		"magazine":1
	},
	"Roubot 500":{ # pistolet basique
		"price":300,
		"damage":40,
		"projectile":true,
		"recoil":7,
		"dispertion":2,
		"magazine":8
	},
	"Vulkan Salamander":{ # pistolet mitrailleur
		"price":375,
		"damage":15,
		"projectile":true,
		"recoil":3,
		"dispertion":3,
		"magazine":20
	},
	"Jagatana":{ # Katana
		"price":1000,
		"damage":50,
		"projectile":false
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
