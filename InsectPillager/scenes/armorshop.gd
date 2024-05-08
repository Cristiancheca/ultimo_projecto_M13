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
	if global.hasskin1 == true:
		$armors/armor1/worth.visible = false
		pass
	if global.hasskin2 == true:
		$armors/armor2/worth.visible = false
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_armor0_pressed():
	global.skin = "0"
	global.toggle_pause()
	queue_free()
	pass # Replace with function body.


func _on_armor1_pressed():
	if global.hasskin1 == true:
		global.skin = "1"
		global.toggle_pause()
		queue_free()
	if global.hasskin1 == false:
		if global.shells >= 100:
			global.shells = global.shells - 100
			global.hasskin1 = true
			global.skin = "1"
			global.toggle_pause()
			queue_free()
	else:
		pass


func _on_armor2_pressed():
	if global.hasskin2 == true:
		global.skin = "2"
		global.toggle_pause()
		queue_free()
	if global.hasskin2 == false:
		if global.shells >= 100:
			global.shells = global.shells - 100
			global.hasskin2 = true
			global.skin = "2"
			global.toggle_pause()
			queue_free()
	else:
		pass


func _on_close_pressed():
	global.toggle_pause()
	queue_free()
	pass # Replace with function body.
