extends Node2D

signal fired(trigger)

export(String) var trigger_name = "unamed"
export(Shape2D) var shape = RectangleShape2D.new()
export(bool) var fire_once = true

onready var area = $Area
onready var collider = $Area/Collider
onready var has_fired = false

func _ready():
	collider.shape = shape
	area.connect("body_entered", self, "on_trigger")

func on_trigger():
	emit_signal("fired", trigger_name)
