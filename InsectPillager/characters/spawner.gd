extends Node2D

var enemy_scene = preload("res://characters/enemies/enemy_warrior1.tscn")
var enemy_maggot = preload("res://characters/enemies/enemy_maggot.tscn")
var enemy_elite = preload("res://characters/enemies/enemy_elite.tscn")

func _ready():
	# Start the initial spawn
	_on_Timer_timeout()

func _on_Timer_timeout():
	# Generate a random number between 0 and 1
	var random_value = randf()

	# Declare new_enemy variable outside the if-else block
	var new_enemy

	# Decide which enemy to spawn based on random value
	if random_value <= 0.33:
		new_enemy = enemy_scene.instance()
	elif random_value <= 0.66:
		new_enemy = enemy_maggot.instance()
	else:
		new_enemy = enemy_elite.instance()

	# Set the initial position of the enemy (adjust as needed)
	new_enemy.position = global_position

	# Add the enemy to the scene
	get_parent().call_deferred("add_child", new_enemy)

	# Restart the timer for the next spawn
	$Timer.start()
