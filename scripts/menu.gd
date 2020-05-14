extends Control

onready var fade = $Fade
onready var animationPlayer = $AnimationPlayer
onready var startButton = $Contents/StartButton

func _ready():
	fade.visible = true
	startButton.grab_focus()
	animationPlayer.play("FadeIn")

func _on_StartButton_pressed():
	animationPlayer.play("FadeOut")
	yield(animationPlayer, "animation_finished")
	assert(get_tree().change_scene("res://acts/Act1.tscn") == OK)
