extends Area2D

signal fired(trigger)

export(String) var trigger_name = "unamed"
export(bool) var fire_once = true

onready var area = $Collider
onready var has_fired = false

func on_trigger(_body):
	if fire_once && !has_fired:
		emit_signal("fired", trigger_name)
	has_fired = true
