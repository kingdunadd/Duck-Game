extends RigidBody

onready var ap = $AnimationPlayer

func _ready():
	ap.play("closedoor")

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		ap.play("opendoor")

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		ap.play("closedoor")
