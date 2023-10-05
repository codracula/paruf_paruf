extends CharacterBody2D
class_name Player
enum{
	MOVE, CLIMB
}
@onready var animatedSprite = $AnimatedSprite2D
@onready var frontRay = $frontCheck
@onready var backRay = $backCheck
@onready var bottomRay = $bottomCheck

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var MAXJUMP_COUNT = 2
var currentJump = 0

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
#		animatedSprite.animation = "idle"

	if is_on_floor():
		currentJump = 0
		print(currentJump);
	if Input.is_action_just_pressed("ui_accept") and can_jump():
		velocity.y = JUMP_VELOCITY
		currentJump = 1
		print(currentJump);
	elif Input.is_action_just_pressed("ui_accept") and currentJump < MAXJUMP_COUNT:
		velocity.y = JUMP_VELOCITY
		currentJump += 1

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction >= 0:
			animatedSprite.flip_h = true
		else:
			animatedSprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animatedSprite.play("idle")

	move_and_slide()

func doubleJump_reset():
	MAXJUMP_COUNT = 1
	
func can_jump():
	return is_on_floor();
	
func wallClimb():
	if frontRay.is_colliding() or backRay.is_colliding(): 
		#rotate sprite to look up
		#stick to wall, not falling
		#if press up move y negative
		#if press down move y positive
		#jump to release from climb, rotate sprite back to normal
		pass
	
		
