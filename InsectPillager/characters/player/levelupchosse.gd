extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var global
var option1 = "test"
var option2 = "test"
var option3 = "test"
var items = ["sword", "dagger", "crossbow", "potion"]

var sword_scene = preload("res://characters/player/items/item_sword.tscn")
var dagger_scene = preload("res://characters/player/items/item_dagger.tscn")
var crossbow_scene = preload("res://characters/player/items/item_crossbow.tscn")
var heal_scene = preload("res://characters/player/items/item_heal.tscn")

func _ready():
	global = get_node("/root/global")
	if global:
		pass
	else:
		$option1.text = "Player not found" # Mensaje de error si player no se encuentra
	# This ensures that the random number generator is initialized differently each time the game starts
	randomize()
	choose_random_item()

func choose_random_item():
	# Get a random index for the items array
	var random_index1 = randi() % items.size()
	var random_index2 = randi() % items.size()
	var random_index3 = randi() % items.size()
	# Choose the item based on the random index
	option1 = items[random_index1]
	option2 = items[random_index2]
	option3 = items[random_index3]
	# Assuming the 'icon' has animations with the same names as the items
	# Set the animation of the icon to the chosen item
	$option1/icon.play(option1)
	$option1.text = option1
	$option2/icon.play(option2)
	$option2.text = option2
	$option3/icon.play(option3)
	$option3.text = option3


func _on_option1_pressed():
	if option1 == "sword":
		var sword = sword_scene.instance()
		get_parent().add_child(sword)
		pass
	if option1 == "dagger":
		var dagger = dagger_scene.instance()
		get_parent().add_child(dagger)
		pass
	if option1 == "crossbow":
		var crossbow = crossbow_scene.instance()
		get_parent().add_child(crossbow)
		pass
	if option1 == "potion":
		var potion = heal_scene.instance()
		get_parent().add_child(potion)
		pass
	queue_free()
	pass # Replace with function body.


func _on_option2_pressed():
	if option2 == "sword":
		var sword = sword_scene.instance()
		get_parent().add_child(sword)
		pass
	if option2 == "dagger":
		var dagger = dagger_scene.instance()
		get_parent().add_child(dagger)
		pass
	if option2 == "crossbow":
		var crossbow = crossbow_scene.instance()
		get_parent().add_child(crossbow)
		pass
	if option2 == "potion":
		var potion = heal_scene.instance()
		get_parent().add_child(potion)
		pass
	queue_free()
	pass # Replace with function body.


func _on_option3_pressed():
	if option3 == "sword":
		var sword = sword_scene.instance()
		get_parent().add_child(sword)
		pass
	if option3 == "dagger":
		var dagger = dagger_scene.instance()
		get_parent().add_child(dagger)
		pass
	if option3 == "crossbow":
		var crossbow = crossbow_scene.instance()
		get_parent().add_child(crossbow)
		pass
	if option3 == "potion":
		var potion = heal_scene.instance()
		get_parent().add_child(potion)
		pass
	queue_free()
	pass # Replace with function body.
