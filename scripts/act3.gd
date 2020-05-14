extends Node2D

onready var map = $MapBase
onready var dialogue = $MapBase/DialogueCanvas/Dialogue
onready var bonfireLight = $MapBase/Chapel/Items/Bedroom/Bonfire/Flame/Light
onready var player = $Player

onready var footsteps = $MapBase/AmbientAudio/FootstepsEffect
onready var blow = $MapBase/AmbientAudio/BlowEffect

func _ready():
	map.wire_events($StoryTriggers.get_children())
	map.wire_events($OptionalTriggers.get_children())
	player.movement_disabled = true
	player.lantern_disabled = true
	map.toggle_lantern3()
	map.toggle_bonfire()
	bonfireLight.scale *= 0.5
	dialogue.say("Wh-what?\n...\nCrap, the fire!\nHow did I even fall asleep again?\n...\nMy lantern...")
	yield(dialogue, "done_talking")
	player.movement_disabled = false

func _on_ST1_fired(_trigger):
	player.movement_disabled = true
	player.lantern_disabled = false
	player.lantern_active = true
	map.toggle_lantern3()
	dialogue.say("This stalker really has a pretty bad sense of hum-\nHuh? What?")
	yield(dialogue, "done_talking")
	footsteps.play()
	dialogue.say("Hey! Who are you? Get away from that fire!\n")
	yield(dialogue, "done_talking")
	footsteps.stop()
	blow.play()
	yield(get_tree().create_timer(2), "timeout")
	map.disable_lights()
	player.visible = false
	yield(get_tree().create_timer(5), "timeout")
	assert(get_tree().change_scene("res://acts/Fin.tscn") == OK)
