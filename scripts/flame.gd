tool
extends Node2D

export(float, 0.1, 5.0) var light_scale = 1.2 setget set_light_scale
export(float, 0.1, 5.0) var energy = 1.0 setget set_energy

onready var light = $Light

var ready = false

func _ready():
	ready = true

func set_light_scale(value):
	if !ready:
		return
	light_scale = value
	light.texture_scale = Vector2(value, value)

func set_energy(value):
	if !ready:
		return
	energy = value
	light.energy = value
