tool
extends StaticBody2D

export(bool) var lit = false setget set_lit

onready var sprite = $Sprite
onready var flame = $Flame

var ready = false

func _ready():
	ready = true

func set_lit(value):
	if !ready:
		return
	lit = value
	if lit:
		sprite.frame = 1
		flame.visible = true
	else:
		sprite.frame = 0
		flame.visible = false
