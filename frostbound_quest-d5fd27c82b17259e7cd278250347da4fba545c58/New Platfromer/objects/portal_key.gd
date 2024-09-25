extends Area2D
 
#didn't have time to add this
func _on_body_entered(body: Node2D) -> void:
	if owner.has_method("teleport"):
		owner.emit_signal("teleport")
