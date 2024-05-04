extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var global

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	if global:
		global.toggle_pause()  # Pausing the game
	else:
		pass # Replace with function body.
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_armor0_pressed():
	
	pass # Replace with function body.


func _on_armor1_pressed():
	
	pass # Replace with function body.


func _on_armor2_pressed():
	
	pass # Replace with function body.
