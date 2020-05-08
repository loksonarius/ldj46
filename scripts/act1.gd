extends Node2D

onready var map = $MapBase
onready var dialogue = $MapBase/DialogueCanvas/Dialogue
onready var player = $Player

func _ready():
	player.lantern_active = true

func _on_OT1_fired(_trigger):
	dialogue.say("Boarded shut. I'll have to go around.")

func _on_OT2_fired(_trigger):
	dialogue.say("The people here are truly damned... such an impressive structure wasted...")

func _on_OT3_fired(_trigger):
	dialogue.say("What in the hell? Was a battle fought here?")

func _on_OT4_fired(_trigger):
	dialogue.say("What could a chapel need to store in such excess?")

func _on_OT5_fired(_trigger):
	dialogue.say("A service entrance! Maybe I'll have more luck here...")

func _on_ST1_fired(_trigger):
	player.movement_disabled = true
	dialogue.say("*knock knock*\n...\n...\nIs this place actually abandoned? I can't wait around with this rain...\nI'll let myself in.")
	yield(dialogue, "done_talking")
	$StoryTriggers/ST2.enabled = true
	player.movement_disabled = false

func _on_ST2_fired(_trigger):
	map.remove_doors()
	dialogue.say("So stagnant...\nand that furnace hasn't been lit in ages....\nNevermind abandoned, this could be a crypt!\n")

func _on_ST3_fired(_trigger):
	dialogue.say("An endless well. Inside the main hall? I wonder how many prayer boys have fallen down this hole?")

func _on_ST4_fired(_trigger):
	$StoryTriggers/ST4.enabled = false
	$StoryTriggers/ST6.enabled = true
	dialogue.say("This basket will be a perfect fire pit. I'll need logs...\nAh, the furnace!")

func _on_ST5_fired(_trigger):
	player.movement_disabled = true
	dialogue.say("The bed's perfect... but I'll freeze without a fire.")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST6_fired(_trigger):
	player.movement_disabled = true
	$StoryTriggers/ST7.enabled = true
	dialogue.say("Just ash in this damn thing!\n...\nMaybe the barrels have some fuel?")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST7_fired(_trigger):
	$StoryTriggers/ST8.enabled = true
	dialogue.say("Thank goodness! Logs and kerosene! No dying tonight!\nTime to light the pit.")

func _on_ST8_fired(_trigger):
	player.movement_disabled = true
	$StoryTriggers/ST5.enabled = false
	$StoryTriggers/ST9.enabled = true
	map.toggle_bonfire()
	dialogue.say("Blazing hot. Perfect. Those barrels should be fine to keep my lantern.")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST9_fired(_trigger):
	player.movement_disabled = true
	player.lantern_disabled = true
	$StoryTriggers/ST10.enabled = true
	map.toggle_lantern1()
	dialogue.say("Done. Now to bed.")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST10_fired(_trigger):
	player.movement_disabled = true
	dialogue.say("It's no inn, but this ditch should be enough for the night.")
	yield(dialogue, "done_talking")
	map.disable_lights()
	player.visible = false
	yield(get_tree().create_timer(3), "timeout")
	assert(get_tree().change_scene("res://acts/Act2.tscn") == OK)
