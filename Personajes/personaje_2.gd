extends CharacterBody2D
@onready var jump_buffer_timer: Timer = %JumpBufferTimer

const SPEED = 200.0
const JUMP_VELOCITY = -380.0
var allow_animation:bool = false
var ray_cast_dimesion = 14
var Tocar3 = false
var salto = false
var piso = true

func _ready():
	$AnimatedSprite2D.play("appear")
	
func _process(_delta):
	_Cambio2()

func _physics_process(delta: float) -> void:
	if is_on_floor():
		salto = false

	if not is_on_floor():
		velocity += get_gravity() * delta
		if piso == true:
			$Coyote_timer.start()
			await ($Coyote_timer.is_stopped())
			if $Coyote_timer.is_stopped():
				salto = true
		piso = false
	if is_on_floor():
		piso = true
	if Input.is_action_just_pressed("flechaU"):
		jump_buffer_timer.start()
	var onJumpBuffer = jump_buffer_timer.time_left > 0
	if (Input.is_action_just_pressed("flechaU") or onJumpBuffer) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		salto = true
	if Input.is_action_just_pressed("flechaU") and is_on_floor() and salto == false:
		velocity.y = JUMP_VELOCITY
		salto = true
	if Input.is_action_just_pressed("flechaU") and !$Coyote_timer.is_stopped() and salto == false:
		velocity.y = JUMP_VELOCITY
		salto = true
	var direction := Input.get_axis("flechaL", "flechaR")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	decide_animation()
	
func decide_animation():
	if not allow_animation: return
	else:
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle")
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk")
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk")
		
		if velocity.y > 0:
			$AnimatedSprite2D.play("jump")
		elif velocity.y < 0:
			$AnimatedSprite2D.play("fall")


func _on_animated_sprite_2d_animation_finished(): #conectar el sigma sigma boy
	allow_animation = true

func _on_coyote_timer_timeout(): #conectar el brr brr
	pass
	

func _Cambio2():
	if Tocar3 == true:
		set_physics_process(false)
		$AnimatedSprite2D.play("cambio")
		await ($AnimatedSprite2D.animation_finished)
		Tocar3 = false
