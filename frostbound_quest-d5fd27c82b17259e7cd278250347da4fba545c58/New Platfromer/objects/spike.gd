extends Area2D


#calls the function die which resets the scene the player is in
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
