extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var global

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	global.lvlcrossbow = 0
	global.lvldagger = 0
	global.lvlsword = 0
	global.lvlswordbool = false
	
	global.enemylvl = 1
	
	#RELLENAR ELS LABELS SCORE I SHELLS
	$Control/scoretitle/score.text = str(global.score)
	$Control/scoretitle2/shells.text = str(global.shells)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_exit_pressed():
	global.toggle_pause()
	Transition.change_scene("res://scenes/mercado.tscn")
	pass # Replace with function body.
