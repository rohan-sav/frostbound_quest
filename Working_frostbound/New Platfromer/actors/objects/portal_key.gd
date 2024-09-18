extends Area2D
 
 
func _on_body_entered(body: Node2D) -> void:
	if owner.has_method("teleport"):
		owner.emit_signal("teleport")
