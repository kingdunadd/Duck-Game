extends Area

onready var ap = $AnimationPlayer

func _ready():
	ap.play("closedoor")

func _on_Area_body_entered(body):
	if is_in_group("Player"):
		ap.play("opendoor")

func _on_Area_body_exited(body):
	if is_in_group("Player"):
		ap.play("closedoor")
