extends Node2D

onready var voice = $VoiceOrchestrator

func _ready():
	voice.connect("received_voice_data", self, "_received_voice_data")
	voice.connect("sent_voice_data", self, "_sent_voice_data")

func _on_SpeakButton_pressed():
	if voice.recording == true:
		voice.recording = false
		$SpeakButton.texture_normal = load("res://addons/godot-voip/icons/microphone-icon-clip-art-98718.png")
	elif voice.recording == false:
		$SpeakButton.texture_normal = load("res://addons/godot-voip/icons/microphone-removebg-preview.png")
		voice.recording = true

func _received_voice_data(data: PoolRealArray, id: int) -> void:
	print("recibiendo")

func _sent_voice_data(data: PoolRealArray) -> void:
	print("enviando")
