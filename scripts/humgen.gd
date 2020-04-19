# based on: https://github.com/godotengine/godot-demo-projects/tree/master/audio/generator
extends Node

export(float) var sample_hz = 22050.0
export(float) var pulse_hz = 110.0
export(float, -80, 24) var volume_db = 0.0
export(float, 0.01, 4.0) var pitch_scale = 1.0

onready var player = $Player

var phase = 0.0
var playback: AudioStreamPlayback = null

func _ready():
	player.stream.mix_rate = sample_hz # Setting mix rate is only possible before play().
	playback = player.get_stream_playback()
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.play()

func _fill_buffer():
	var increment = pulse_hz / sample_hz
	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		playback.push_frame(Vector2.ONE * sin(phase * TAU)) # Audio frames are stereo.
		phase = fmod(phase + increment, 1.0)
		to_fill -= 1

func _process(_delta):
	_fill_buffer()
