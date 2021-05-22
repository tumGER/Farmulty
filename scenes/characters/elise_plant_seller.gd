extends Node2D

onready var global = get_node("/root/Global")

func _process(delta):
	var frame = $AnimatedSprite.frame
	$AnimatedSprite/Hair.frame = frame
	$AnimatedSprite/Hand.frame = frame

func buy_shovel():
	var Overworld = get_node("/root/Overworld")
	var player = Overworld.get_node("Character")
	var inv = player.get_node("Inventory")

	if inv.decrease_item_total("Carrot", 15):
		inv.add_item("Shovel", 1)

func gave(item: String):
	var Overworld = get_node("/root/Overworld")
	var player = Overworld.get_node("Character")
	var inv = player.get_node("Inventory")

	if inv.decrease_item_amount(item):
		var i = inv.add_item(str(item) + " Seed", 3)
		if i != 0:
			var pickups = get_parent().get_parent().get_node("Pickups")

			for _x in range(i):
				var overworld_pickup = load("res://scenes/items/overworld_pickup.tscn").instance()
				pickups.add_child(overworld_pickup)
				overworld_pickup.position = position + Vector2(0, 8)
				overworld_pickup.add_item(item + " Seed")

const INTRODUCTION = {
	"character": "Elise - Plant Lover",
	"text": "Do you like plants as much as I do? I can offer you some sweet deals for your plants!",
	"is_question": true,
	"button_amount": 3,
	"input1": {
		"text": "Give Carrot for Seeds",
	},
	"input2": {
		"text": "Give Wheat for Seeds",
	},
	"input3": {
		"text": "Give 15 Carrots for Shovel",
	}
}

func _on_DialogArea_chosen_option(option):
	match option:
		1:
			gave("Carrot")
		2:
			gave("Wheat")
		3:
			buy_shovel()
		_:
			return

func _ready():
	$DialogArea.dialog = INTRODUCTION
