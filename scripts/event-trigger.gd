extends Area2D

signal fired(trigger)
signal interactable
signal uninteractable

export(String) var trigger_name = "unamed"
export(bool) var fire_once = true
export(bool) var interactable = false
export(bool) var enabled = true

onready var area = $Collider
onready var has_fired = false

var active = false

func fire():
	emit_signal("fired", trigger_name)
	has_fired = true
	if interactable:
		emit_signal("uninteractable")

func could_fire():
	if active && enabled:
		return !fire_once || (fire_once && !has_fired)

func _process(_delta):
	if active && enabled:
		if could_fire():
			if interactable:
				if Input.is_action_pressed("interact"):
					fire()
			else:
				fire()

func _on_EventTrigger_body_entered(_body):
	self.active = true
	if could_fire():
		emit_signal("interactable")

func _on_EventTrigger_body_exited(_body):
	self.active = false
	if interactable:
		emit_signal("uninteractable")
