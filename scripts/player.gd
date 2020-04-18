extends KinematicBody2D

export(int, 1, 1000) var MAX_SPEED = 50
export(int, 1, 1000) var MIN_SPEED = 2
export(int, 1, 10000) var ACCELERATION = 50
export(float, 0.1, 1.0) var FRICTION = 0.6
export(int, 0, 100) var LOOK_AHEAD = 15

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var camera = $Camera
onready var collider = $Collider
onready var composite = $SpriteComposite
onready var head = $SpriteComposite/Head
onready var body = $SpriteComposite/Body

var current_vel = Vector2.ZERO
var input_vel = Vector2.ZERO

func _ready():
	camera.current = true

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	composite.look_at(mouse_pos)
	camera.offset = to_local(mouse_pos).normalized() * LOOK_AHEAD
	var x_dis = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y_dis = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vel = Vector2(x_dis, y_dis).normalized()
	if input_vel.length_squared() == 0.0:
		animationState.travel("Idle")
	else:
		animationState.travel("Walk")

func _physics_process(_delta):
	if input_vel.length_squared() == 0.0:
		if current_vel.length() >= MIN_SPEED:
			current_vel *= FRICTION
		else:
			current_vel = Vector2.ZERO
	else:
		current_vel += input_vel * ACCELERATION
	current_vel = move_and_slide(current_vel.clamped(MAX_SPEED))
