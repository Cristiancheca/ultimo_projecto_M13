extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_paused = false
var actualhp
#SKIN PLAYER
var skin = "0"
var hasskin1 = false
var hasskin2 = false
#CURRENCY
var shells = 100

#DURING EACH RUN
var score = 0
var startweapon = "null"

var lvlsword = 0
var lvlswordbool = false
var lvldagger = 0
var lvlcrossbow = 0

var enemylvl = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = not get_tree().paused
