extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var last_seen : Vector3
var speed : float = 3
var in_radius : bool = false
var seen : bool = false
var player_obj
var hurting_player : bool = false
var hit_countdown = 0
var hit_cooldown = 1
var orig_y
# Called when the node enters the scene tree for the first time.
func _ready():
	orig_y = translation.y
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_obj = get_node("/root/Game/Player")
	if in_radius:
		print(player_obj.translation)
		print("dist ", player_obj.translation.distance_to(translation))
		var vect = (player_obj.translation-translation).normalized()
		translation += vect*speed*delta
		transform.origin.y = orig_y

	
	if hurting_player:
		if hit_countdown <= 0:
			Global.add_to_health(-30)
			$AudioStreamPlayer.play()
			hit_countdown += hit_cooldown
		else:
			hit_countdown -= delta
		


func _on_Area_body_entered(body):
	if body.name == "Player":
		in_radius = true
	pass # Replace with function body.


func _on_Area_body_exited(body):
	pass # Replace with function body.


func _on_VisibilityNotifier_screen_exited():
	seen = false


func _on_VisibilityNotifier_camera_entered(camera):
	seen = true
	pass # Replace with function body.


func _on_HurtArea_body_entered(body):
	if body.name == "Player":
		hurting_player = true
		
	pass # Replace with function body.


func _on_HurtArea_body_exited(body):
	if body.name == "Player":
		hurting_player = false
	pass # Replace with function body.
