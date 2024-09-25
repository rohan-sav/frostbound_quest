extends Area2D
 
#Checks if the player has the function level_clear triggering the action to change the scene to the next level
func _on_body_entered(body: Node2D) -> void:
	if owner.has_method("level_clear"):
		owner.level_clear()
