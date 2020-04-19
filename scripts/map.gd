extends Node2D

onready var groundTiles = $Chapel/Ground
onready var wallTiles = $Chapel/Walls

onready var ground_material = load("res://materials/ground-material.tres")
onready var wall_material = load("res://materials/wall-material.tres")

func _ready():
	groundTiles.material = ground_material
	wallTiles.material = wall_material
