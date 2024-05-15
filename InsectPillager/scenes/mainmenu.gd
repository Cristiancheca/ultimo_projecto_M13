extends Node2D

onready var MainMenu = $Menu
onready var Options = $Opciones
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_play_pressed():
	$buttonsound.play()
	Transition.change_scene("res://scenes/mercado.tscn")
	pass


func _on_options_pressed():
	$buttonsound.play()
	show_and_hide(Options,MainMenu)


func show_and_hide(first,Second):
	first.show()
	Second.hide()


func _on_exit_pressed():
	$buttonsound.play()
	get_tree().quit()

func _on_CheckBox_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_Master_value_changed(value):
	Volumen(0,value)


func Volumen(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index,value)


func _on_Music_value_changed(value):
	Volumen(1,value)


func _on_Efects_value_changed(value):
	Volumen(2,value)


func _on_Volver_al_menu_pressed():
	$buttonsound.play()
	show_and_hide(MainMenu,Options)
