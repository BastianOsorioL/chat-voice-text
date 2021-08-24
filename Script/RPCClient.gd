extends Node


var ownPlayerId
onready var label = get_tree().get_root().get_node("World/Label")
var positionX = 50
var positionY = 50
var verify = []
var id_receiver

onready var text_chat = preload("res://Scenes/TextChat.tscn").instance()

remote func receiverPlayerId(playerId):
	ownPlayerId = playerId
	
remote func receivePlayers(players):
	var lastIndex = len(players)-1
	label.text = "Bienvenido jugador " + str(players[lastIndex]["playerId"])

func sendIdPrivateChat(player_id):
	rpc_id(1, "receive_private_chat_player", player_id)
	
remote func receive_player_private(players_id):
	for player in players_id:
		var result = verify.find(player)
		if player != get_tree().get_network_unique_id() && result == -1:
			create_button(player)
			
func create_button(player):
	var button = Button.new()
	button.set_size(Vector2(80,20))
	button.set_position(Vector2(positionX, positionY))
	button.text = str(player)
	button.name = str(player)
	button.show()
	button.connect("pressed", self, "_button_pressed", [button])
	get_tree().get_root().get_node("World/PrivateChat").add_child(button)
	positionY += 40
	verify.append(player)
			
func _button_pressed(target):
	id_receiver = target.get_name()
	get_tree().get_root().get_node("World/RoomsChatButton").hide()
	get_tree().get_root().get_node("World/PrivateChatButton").hide()
	get_tree().get_root().get_node("World/PrivateChat").add_child(text_chat)	
