extends Node2D

signal done_talking

export(float, 0.01, 5.0) var TEXT_SPEED = 0.07

onready var tie = $Center/TIE
onready var buttonIndicator = $Center/ButtonIndicator
onready var animationPlayer = $AnimationPlayer

var show_indicator = false
var done = true
var queue = []

func _ready():
	reset()
	animationPlayer.play("Default")

func _input(event):
	if event.is_action_pressed("ui_accept") && done:
		visible = false
		tie.reset()
		emit_signal("done_talking")

func reset():
	tie.reset()
	tie.set_color(Color.white)
	visible = false
	done = true
	queue = []
	show_indicator = false

func say(string):
	queue.append(string)

func _output_line():
	if len(queue) <= 0 || visible:
		return
	var string = queue.front()
	queue.remove(0)
	tie.buff_text(string, TEXT_SPEED)
	visible = true
	done = false
	tie.set_state(tie.STATE_OUTPUT)

func _process(_delta):
	_output_line()
	buttonIndicator.visible = show_indicator

func _on_TIE_enter_break():
	show_indicator = true

func _on_TIE_resume_break():
	show_indicator = false

func _on_TIE_buff_end():
	show_indicator = true
	done = true
