extends Node2D

export(float, 0.01, 0.5) var TEXT_SPEED = 0.1

onready var tie = $Center/TIE
onready var buttonIndicator = $Center/ButtonIndicator
onready var animationPlayer = $AnimationPlayer

var show_indicator = false
var done = false

func _ready():
	reset()
	animationPlayer.play("Default")
	say("MAMA MIA, THAT'S A LONG TEXT RIGHT HERE... Like... a lot of text maaaaaaan")

func _input(event):
	if event.is_action_pressed("ui_accept") && done:
		visible = false

func reset():
	tie.reset()
	tie.set_color(Color.white)
	visible = false
	done = false
	show_indicator = false

func say(string):
	tie.buff_text(string, TEXT_SPEED)
	visible = true
	tie.set_state(tie.STATE_OUTPUT)

func _process(_delta):
	buttonIndicator.visible = show_indicator

func _on_TIE_enter_break():
	show_indicator = true

func _on_TIE_resume_break():
	show_indicator = false

func _on_TIE_buff_end():
	show_indicator = true
	done = true
