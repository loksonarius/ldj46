extends Control

onready var fade = $Fade
onready var animationPlayer = $AnimationPlayer

func _ready():
	fade.visible = true
	animationPlayer.play("FadeIn")

func _on_StartButon_pressed():
	animationPlayer.play("FadeOut")
	yield(animationPlayer, "animation_finished")
	assert(get_tree().change_scene("res://acts/Act1.tscn") == OK)
