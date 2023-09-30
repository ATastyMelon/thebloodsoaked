extends CharacterBody3D

@onready var head = $Head

var current_speed = 7.5
const walking_speed = 7.5
const sprinting_speed = 10.0

const damage = 10

const jump_velocity = 5
const mouseSens = 0.35
var lerp_speed = 7.0
var direction = Vector3.ZERO
var gravity = 17

var rng = RandomNumberGenerator.new()

@onready var muzzle_flash = $CanvasLayer/Control/MuzzleFlash
@onready var muzzle_flash_light = $Head/Camera3D/MuzzleLight


@onready var jumpSound = $JumpSound
@onready var gunSound = $GunshotSound

@onready var raycast = $Head/Camera3D/RayCast3D

func fire():
	gunSound.play()
	muzzle_flash.show()
	muzzle_flash_light.show()
	await get_tree().create_timer(0.1).timeout
	muzzle_flash_light.hide()
	muzzle_flash.hide()
	if raycast.is_colliding():
		var target = raycast.get_collider()
		if target.is_in_group("Enemy"):
			target.health -= damage
		

func _ready():
	gunSound.volume_db = -25
	#muzzle_flash.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(_delta):
	if (position.y <= -50):
		Functions.loading_screen_goto("res://Scenes/Game.tscn")

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouseSens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouseSens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
	if Input.is_action_just_pressed("shoot"):
		fire()
		
	if Input.is_action_just_pressed("closegame"):
		Functions.loading_screen_goto_mainnmenu("res://Scenes/MainMenu.tscn")
		
func _physics_process(delta):
	
	if Input.is_action_pressed("sprint"):
		current_speed = sprinting_speed
	else:
		current_speed = walking_speed
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		rng.randomize()
		jumpSound.pitch_scale = rng.randf_range(0.8, 1.3)
		jumpSound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta * lerp_speed)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
