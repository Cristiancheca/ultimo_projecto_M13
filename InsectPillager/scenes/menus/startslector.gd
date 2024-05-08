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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_sword_button_pressed():
	global.toggle_pause()
	global.startweapon = "sword"
	Transition.change_scene("res://scenes/level.tscn")
	pass # Replace with function body.


func _on_dagger_button_pressed():
	global.toggle_pause()
	global.startweapon = "dagger"
	Transition.change_scene("res://scenes/level.tscn")
	pass # Replace with function body.


func _on_crossbow_button_pressed():
	global.toggle_pause()
	global.startweapon = "crossbow"
	Transition.change_scene("res://scenes/level.tscn")
	pass # Replace with function body.


func _on_Button_pressed():
	global.toggle_pause()
	queue_free()
