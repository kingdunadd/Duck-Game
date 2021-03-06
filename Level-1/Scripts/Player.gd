extends KinematicBody

export var speed = 20
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3

var damage = 100
var health = 400

onready var head = $Head
onready var camera = $Head/Camera
onready var gun = $Head/cybergun

#onready var aimcast = $head/Camera/AimCast
#onready var muzzle = $head/Muzzle
#onready var duck = preload("res://Weapon/DuckProjectile.tscn")

var velocity = Vector3()
var camera_x_rotation = 0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
		gun.rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
		
		var x_delta = event.relative.y*mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if health <= 0:
		# go to menu screen
		print("Game Over")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	var direction = Vector3()
	if Input.is_action_pressed("forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("backward"):
		direction += head_basis.z

	if Input.is_action_pressed("left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("right"):
		direction += head_basis.x
		
	direction = direction.normalized()

	velocity = velocity.linear_interpolate(direction*speed, acceleration*delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	velocity = move_and_slide(velocity, Vector3.UP)


#	if Input.is_action_just_pressed("fire"):
#		if aimcast.is_colliding():
#			var b = duck.instance()
#			muzzle.add_child(b)
#			b.look_at(aimcast.get_collision_point(), Vector3.UP)
#			b.shoot = true

