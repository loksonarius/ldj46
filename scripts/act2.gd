extends Node2D

onready var map = $MapBase
onready var dialogue = $MapBase/DialogueCanvas/Dialogue
onready var bonfireLight = $MapBase/Chapel/Items/Bedroom/Bonfire/Flame/Light
onready var player = $Player

var kindling_found = 0

func _ready():
	player.movement_disabled = true
	player.lantern_disabled = true
	map.toggle_lantern2()
	map.toggle_bonfire()
	bonfireLight.scale *= 0.5
	dialogue.say("I'm freezing! The damn fire went out... I'll have to relight it.\n...\nWhere's my lantern?")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST1_fired(_trigger):
	$StoryTriggers/ST1.enabled = false
	$StoryTriggers/ST2.enabled = true
	map.toggle_lantern2()
	player.lantern_disabled = false
	player.lantern_active = true
	dialogue.say("Alright, back to those barrels near the oven...")

func _on_ST2_fired(_trigger):
	dialogue.say("Is that where I left the lantern before resting...?")

func _on_ST3_fired(_trigger):
	player.movement_disabled = true
	dialogue.say("What in the hell? Is the door gone?")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST4_fired(_trigger):
	player.movement_disabled = true
	$StoryTriggers/ST5.enabled = true
	$StoryTriggers/ST6.enabled = true
	dialogue.say("...\n..\nNo no no, this isn't...\nI mean... how!?\nAlright, someone's definitely messing with me here. No more shut-eye.\n...\nI'll still need to keep the fire alive, though. I'll need logs and kindling.\nTime to forage around.")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST5_fired(_trigger):
	player.movement_disabled = true
	kindling_found += 1
	if kindling_found == 1:
		dialogue.say("Lumber -- great! It's dry enough too. I'll just need some kindling to get it going. Anything should be fine...\n...\nAh, maybe around the altar...?")
	else:
		$StoryTriggers/ST7.enabled = true
		dialogue.say("Perfect! This wood should last me a few hours.\nI should hurry and relight the fire.")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST6_fired(_trigger):
	player.movement_disabled = true
	kindling_found += 1
	if kindling_found == 1:
		dialogue.say("Well it's far from ideal... but these holy books should work.\n...\nI don't think I could be any more damned right now anyway...\nI should look around more. Maybe that storage room...?")
	else:
		$StoryTriggers/ST7.enabled = true
		dialogue.say("Well it's far from ideal... but these holy books should work.\n...\nI don't think I could be any more damned right now anyway...\nI should hurry and relight the fire.")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST7_fired(_trigger):
	player.movement_disabled = true
	bonfireLight.scale *= 2.0
	$StoryTriggers/ST8.enabled = true
	dialogue.say("Bright hot, perfect for my frozen fingers.\nMy breath is feeling quite heavy after carrying those logs. I'll have a seat there by the desk for now...")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST8_fired(_trigger):
	player.movement_disabled = true
	dialogue.say("That barricade... did I actually-*cough* sleep through all that?\nHmmm... *cough cough*\nSitting here isn't helping at all with my breathing...\nThe dust and dirt feel thicker than when I came.\nRegardless, I'll need to-*cough* *cough*\nkeep..\nwatch...\n...\n...")
	yield(dialogue, "done_talking")
	map.disable_lights()
	player.visible = false
	yield(get_tree().create_timer(3), "timeout")
	assert(get_tree().change_scene("res://acts/Act3.tscn") == OK)
