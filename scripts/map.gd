extends Node2D

export(NodePath) var player_node_path = null

onready var ambientDark = $AmbientDark
onready var groundTiles = $Chapel/Ground
onready var wallTiles = $Chapel/Walls
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
