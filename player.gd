extends CharacterBody2D
class_name Player
enum{
	MOVE, CLIMB
}
@onready var animatedSprite = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var MAXJUMP_COUNT = 2
var currentJump = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor():
		currentJump = 0
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		currentJump = 1
	elif Input.is_action_just_pressed("ui_accept") and currentJump < MAXJUMP_COUNT and not is_on_floor():
		currentJump += 1
#		fix double jump
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animatedSprite.animation = "idle"

	move_and_slide()

func doubleJump_reset():
	MAXJUMP_COUNT = 1
	
