extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var option1 = "test"
var option2 = "test"
var option3 = "test"
var items = ["manuscript", "sword", "dagger", "potion"]

func _ready():
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
	$option2/icon.play(option2)
	$option3/icon.play(option3)
