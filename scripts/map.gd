extends Node2D

export(NodePath) var player_node_path = null

onready var ambientDark = $AmbientDark
onready var groundTiles = $Chapel/Ground
onready var wallTiles = $Chapel/Walls
onready var doorTiles = $Chapel/Doors
onready var dialogueBox = $DialogueCanvas/Dialogue

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

func toggle_doors():
	doorTiles.visible = !doorTiles.visible
	doorTiles.set_collision_layer_bit(0, !doorTiles.get_collision_layer_bit(0))

func _on_Dialogue_done_talking():
	player.movement_disabled = false
