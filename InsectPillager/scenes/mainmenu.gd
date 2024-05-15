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


# Método llamado cuando se presiona el botón de "play" i inicia el juego
func _on_play_pressed():
	$buttonsound.play()
	Transition.change_scene("res://scenes/mercado.tscn")
	pass

# Método llamado cuando se presiona el botón de "opciones" i entra en el menu de opciones
func _on_options_pressed():
	$buttonsound.play()
	show_and_hide(Options,MainMenu)


func show_and_hide(first,Second):
	first.show()
	Second.hide()

# Método llamado cuando se presiona el botón de "salir" i sale del juego
func _on_exit_pressed():
	$buttonsound.play()
	get_tree().quit()

# Método llamado cuando se cambia la pantalla a fullscreem
func _on_CheckBox_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


# Método llamado cuando cambia el valor del control deslizante "Master"
func _on_Master_value_changed(value):
	Volumen(0,value)


func Volumen(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index,value)


# Método llamado cuando cambia el valor del volumne de la musica
func _on_Music_value_changed(value):
	Volumen(1,value)


# Método llamado cuando cambia el valor del volumen de los efectos
func _on_Efects_value_changed(value):
	Volumen(2,value)


# Método llamado cuando se presiona el botón de "volver al menú" para salir de las opciones
func _on_Volver_al_menu_pressed():
	$buttonsound.play()
	show_and_hide(MainMenu,Options)
