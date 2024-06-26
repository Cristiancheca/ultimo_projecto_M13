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

#al clicar la aramadura 0 o mejor dicho la deafault se pone resta misma 
func _on_armor0_pressed():
	$buttonsound.play()
	yield($buttonsound, "finished")
	global.skin = "0"
	global.toggle_pause()
	queue_free()
	pass # Replace with function body.

#Al clicar la armadura 1 si tienes suficientes "shells" se pondra pero si no tienes suficientes no se pondra 
func _on_armor1_pressed():
	$buttonsound.play()
	yield($buttonsound, "finished")
	if global.hasskin1 == true:
		global.skin = "1"
		global.toggle_pause()
		queue_free()
	if global.hasskin1 == false:
		if global.shells >= 200:
			global.shells = global.shells - 200
			global.hasskin1 = true
			global.skin = "1"
			global.toggle_pause()
			queue_free()
		else:
			$armors/armor1.modulate = Color(2, 1, 1, 1)
	else:
		pass

#Al clicar la armadura 2 si tienes suficientes "shells" se pondra pero si no tienes suficientes no se pondra 
func _on_armor2_pressed():
	$buttonsound.play()
	yield($buttonsound, "finished")
	if global.hasskin2 == true:
		global.skin = "2"
		global.toggle_pause()
		queue_free()
	if global.hasskin2 == false:
		if global.shells >= 220:
			global.shells = global.shells - 220
			global.hasskin2 = true
			global.skin = "2"
			global.toggle_pause()
			queue_free()
		else:
			$armors/armor2.modulate = Color(2, 1, 1, 1)
	else:
		pass

#Este boton es para cerrar la ventana de las armaduras
func _on_close_pressed():
	$buttonsound.play()
	yield($buttonsound, "finished")
	global.toggle_pause()
	queue_free()
	pass # Replace with function body.
