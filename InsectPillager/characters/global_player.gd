extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_paused = false
var actualhp

#CURRENCY
var Shells = 0

#DURING EACH RUN
var startweapon = 0

var lvlsword = 0
var lvldagger = 0
var lvlcrossbow = 0

var enemylvl = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = not get_tree().paused
