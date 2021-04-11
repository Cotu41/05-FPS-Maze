extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("CaseAction")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.name == "Player":
		if Global.player_health != 100:
			Global.add_to_health(30)
			$AudioStreamPlayer.play()
			queue_free()
	pass # Replace with function body.
