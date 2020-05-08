extends Node2D

export(NodePath) var player_node_path = null

onready var ambientDark = $AmbientDark
onready var groundTiles = $Chapel/Ground
onready var wallTiles = $Chapel/Walls
onready var doorTiles = $Chapel/Doors
onready var dialogueBox = $DialogueCanvas/Dialogue
onready var lantern1 = $Chapel/Items/Bedroom/BedSide/Barrel4/Lantern
onready var lantern2 = $Chapel/Items/Bedroom/BedSide/Barrel3/Lantern
onready var lantern3 = $Chapel/Items/Bedroom/LadderHole/Lantern
onready var bonfire = $Chapel/Items/Bedroom/Bonfire

var following = false
var player = null

func _ready():
	ambientDark.visible = true
	if player_node_path != null:
		following = true
		player = get_node(player_node_path)

func _process(_delta):
	if following:
		dialogueBox.global_position = player.global_position + Vector2.UP * 30

func remove_doors():
	doorTiles.queue_free()

func toggle_lantern1():
	lantern1.visible = !lantern1.visible

func toggle_lantern2():
	lantern2.visible = !lantern2.visible

func toggle_lantern3():
	lantern3.visible = !lantern3.visible

func toggle_bonfire():
	bonfire.lit = !bonfire.lit 

func disable_lights():
	bonfire.lit = false
	lantern1.visible = false
	lantern2.visible = false
	lantern3.visible = false
	player.lantern_disabled = true
