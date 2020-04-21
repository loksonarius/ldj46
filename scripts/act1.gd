extends Node2D

onready var map = $MapBase
onready var dialogue = $MapBase/DialogueCanvas/Dialogue

func _on_OT1_fired(_trigger):
	dialogue.say("The front doors are boarded? Strange... maybe there's another entrance?")

func _on_OT2_fired(_trigger):
	dialogue.say("This chapel is quite sizeable! It's impressive given the demographic around here...")
