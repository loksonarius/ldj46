extends Area2D

signal fired(trigger)
signal active(trigger)
signal inactive(trigger)

export(String) var trigger_name = "unamed"
export(bool) var fire_once = true
export(bool) var interactable = false
export(bool) var enabled = true

onready var area = $Collider
onready var has_fired = false

var active = false setget set_active

func set_active(value):
	active = value

func fire():
	emit_signal("fired", trigger_name)
	has_fired = true

func _process(_delta):
	if active:
		if interactable:
			if !fire_once || (fire_once && !has_fired):
				if Input.is_action_pressed("interact"):
					fire()
		else:
			if !fire_once || (fire_once && !has_fired):
				fire()

func _on_EventTrigger_body_entered(_body):
	self.active = true

func _on_EventTrigger_body_exited(_body):
	self.active = false
