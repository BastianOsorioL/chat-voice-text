extends Node2D

onready var menu_chat = preload("res://Scenes/MenuChat.tscn").instance()
onready var private_chat = preload("res://Scenes/PrivateChat.tscn").instance()
var is_private

var network = NetworkedMultiplayerENet.new()
var ip = "127.0.0.1"
var port = 1909

func _ready():
	connect_to_server()

func connect_to_server():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)

	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "on_connection_succeeded")

func _on_connection_failed():
	print("Failed to connect")

func on_connection_succeeded():
	print("Succesfully connected")

func _on_RoomsChatButton_pressed():
	is_private = false
	$RoomsChatButton.hide()
	$PrivateChatButton.hide()
	get_tree().get_root().get_node("World").add_child(menu_chat)

func _on_PrivateChatButton_pressed():
	is_private = true
	var player_id = get_tree().get_network_unique_id()
	$RoomsChatButton.hide()
	$PrivateChatButton.hide()
	get_tree().get_root().get_node("World").add_child(private_chat)
	$RPCClient.sendIdPrivateChat(player_id)

#func _on_RoomsVoiceButton_pressed():
#	$RoomsChatButton.hide()
#	$PrivateChatButton.hide()
