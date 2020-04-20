extends KinematicBody2D

export(int, 1, 1000) var MAX_SPEED = 35
export(int, 1, 1000) var MIN_SPEED = 2
export(int, 1, 10000) var ACCELERATION = 50
export(float, 0.1, 1.0) var FRICTION = 0.8
export(int, 0, 100) var LOOK_AHEAD = 15
export(int, 5, 15) var ARM_LENGTH = 6

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var camera = $Camera
onready var collider = $Collider
onready var composite = $SpriteComposite
onready var occluder = $Occluder
onready var head = $SpriteComposite/Head
onready var body = $SpriteComposite/Body
onready var lantern = $Lantern

var current_vel = Vector2.ZERO
var input_vel = Vector2.ZERO
var lantern_active = false

func _ready():
	camera.current = true

func _input(event):
	if event.is_action_pressed("lantern"):
		lantern_active = !lantern_active

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var direction_vec = to_local(mouse_pos).normalized()
	composite.look_at(mouse_pos)
	collider.look_at(mouse_pos)
	camera.offset = direction_vec * LOOK_AHEAD
	var x_dis = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_dis = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vel = Vector2(x_dis, y_dis).normalized()
	if input_vel.length_squared() == 0.0:
		animationState.travel("Idle")
	else:
		animationState.travel("Walk")
	if lantern_active:
		lantern.position = direction_vec * ARM_LENGTH
		lantern.visible = true
	else:
		lantern.visible = false

func _physics_process(_delta):
	if input_vel.length_squared() == 0.0:
		if current_vel.length() >= MIN_SPEED:
			current_vel *= FRICTION
		else:
			current_vel = Vector2.ZERO
	else:
		current_vel += input_vel * ACCELERATION
	current_vel = move_and_slide(current_vel.clamped(MAX_SPEED))
