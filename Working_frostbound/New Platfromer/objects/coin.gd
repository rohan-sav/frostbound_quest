extends Area2D

@export var score: int

func _on_body_entered(body):
	$AnimationPlayer.play("pick_up")
	score += 1
	print(score)
