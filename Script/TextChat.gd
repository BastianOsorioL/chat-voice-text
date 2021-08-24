extends Control

onready var chat_display = $VBoxContainer/TextEdit
onready var chat_input = $VBoxContainer/LineEdit
onready var voice_chat = preload("res://Scenes/VoiceChat.tscn").instance()

var id_user
var type_chat
var id_receiver

func _ready():
	type_chat = get_tree().get_root().get_node("World").is_private
	id_user = get_tree().get_network_unique_id()
	chat_input.connect("text_entered", self, "send_message")
	
func send_message(msg):
	chat_input.text = ""
	if !type_chat:
		var room_chat = get_tree().get_root().get_node("World/MenuChat").room_chat
		rpc_id(1, "receive_message_server", id_user, room_chat, msg)
	else:
		id_receiver = int(get_tree().get_root().get_node("World/RPCClient").id_receiver)
		rpc_id(1, "receive_private_message_server", id_user, msg, id_receiver)

remote func receive_msg_server(id, msg):
	chat_display.text += str(id) + ": " + msg + "\n"

func _on_TextureButton_pressed():
	var voice = get_tree().get_root().get_node("World/VoiceChat/VoiceOrchestrator")
	if voice.recording == true:
		voice.recording = false
		$SpeakButton.texture_normal = load("res://addons/godot-voip/icons/microphone-icon-clip-art-98718.png")
	elif voice.recording == false:
		$SpeakButton.texture_normal = load("res://addons/godot-voip/icons/microphone-removebg-preview.png")
		voice.recording = true
