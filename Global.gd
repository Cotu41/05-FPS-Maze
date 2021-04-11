extends Node

const SAVE_PATH = "res://settings.cfg"

var player_health := 100
var player : Object
var save_file = ConfigFile.new()
var inputs = ["left","right","forward","back"]

onready var HUD = get_node_or_null("/root/Main/UI/HUD")
onready var Player = get_node_or_null("/root/Main/Player")
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	load_input()
	


func _unhandled_input(_event):
	if Input.is_action_just_pressed("menu"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu != null:
			if not menu.visible:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				menu.show()
				get_tree().paused = true
			else:
				save_input()
				menu.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				get_tree().paused = false

func add_to_health(amount : float):
	player_health += amount
	if player_health <= 0:
		player_health = 0
		game_over()
	elif player_health > 100: player_health = 100

func game_over():
	get_tree().change_scene("res://Assets/DeathMenu.tscn")
	player_health = 100
	print("game over")

func load_input():
	var error = save_file.load(SAVE_PATH)
	if error != OK:
		print("Failed loading file")
		return
	
	for i in inputs:
		var key = save_file.get_value("Inputs", i, null)
		InputMap.action_erase_events(i)
		InputMap.action_add_event(i, key)


func save_input():
	for i in inputs:
		var actions = InputMap.get_action_list(i)
		for a in actions:
			save_file.set_value("Inputs", i, a)
	save_file.save(SAVE_PATH)
