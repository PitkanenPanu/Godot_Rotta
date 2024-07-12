extends CharacterBody2D

const speed = 100
var current_dir = "none"

var health = 100
var health_max = 100
var health_min = 0

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(_delta):
	var input_vector = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized() * speed
		velocity = input_vector
		update_animation(input_vector)
	else:
		velocity = Vector2.ZERO
		play_anim(0)
	
	move_and_slide()

func update_animation(direction):
	if direction.x > 0:
		current_dir = "right"
		play_anim(1)
	elif direction.x < 0:
		current_dir = "left"
		play_anim(1)
	elif direction.y > 0:
		current_dir = "down"
		play_anim(1)
	elif direction.y < 0:
		current_dir = "up"
		play_anim(1)

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		else:
			anim.play("side_idle")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		else:
			anim.play("side_idle")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		else:
			anim.play("front_idle")
	
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		else:
			anim.play("back_idle")
