extends Node2D

onready var map = $MapBase
onready var dialogue = $MapBase/DialogueCanvas/Dialogue
onready var player = $Player

func _on_OT1_fired(_trigger):
	dialogue.say("Boarded up shut? Strange... maybe there's another entrance?")

func _on_OT2_fired(_trigger):
	dialogue.say("This chapel is quite sizeable! It's impressive given the demographic around here...")

func _on_OT3_fired(_trigger):
	dialogue.say("What in the hell? A barricade? What went down here?")

func _on_OT4_fired(_trigger):
	dialogue.say("A closet full of barrels? I wonder what's inside them...")

func _on_OT5_fired(_trigger):
	dialogue.say("A back door! Looks like a living quarters extension. I need to ask why they shut the front doors.")

func _on_ST1_fired(_trigger):
	player.movement_disabled = true
	dialogue.say("*knock knock*\n*knock knock knock*\n...\nIs this place actually abandoned? The rain approaches quickly. I'll have to let myself in.")

func _on_ST2_fired(_trigger):
	map.toggle_doors()
	dialogue.say("What a heavy smell. The dust and mud in here... there's no doubt this place is definitely abandoned.")
