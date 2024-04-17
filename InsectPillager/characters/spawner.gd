extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy_scene = preload("res://characters/enemies/enemy_warrior1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_enemy = enemy_scene.instance()
	new_enemy.position = Vector2(606, 249)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	# Instancia un nuevo enemigo
	var new_enemy = enemy_scene.instance()
	 # Establece la posición inicial del enemigo (ajusta según sea necesario)
	new_enemy.position = global_position
	 # Añade el enemigo al escenario
	get_parent().add_child(new_enemy)
	$Timer.start()
	pass # Replace with function body.
