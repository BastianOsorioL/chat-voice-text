extends Node2D

onready var text_chat_scene = preload("res://Scenes/TextChat.tscn").instance()
onready var voice_chat = preload("res://Scenes/VoiceChat.tscn").instance()
enum rooms_chat {GAMIFICACION, INSIGNIAS, MICRO, STACKBIO}
var room_chat

func _ready():
	pass
	
func hide_nodes():
	$Button.hide()
	$Button2.hide()
	$Button3.hide()
	$Button4.hide()

func _on_Button_pressed():
	get_tree().get_root().get_node("World").add_child(voice_chat)
	enter_chat(rooms_chat.GAMIFICACION)

func _on_Button2_pressed():
	enter_chat(rooms_chat.INSIGNIAS)

func enter_chat(room):
	var user_id = get_tree().get_network_unique_id()
	room_chat = room
	hide_nodes()
	get_tree().get_root().get_node("World/MenuChat").add_child(text_chat_scene)
	rpc_id(1, "receive_chat_players", user_id, room_chat)
