extends CharacterBody2D


const SPEED = 230.0
const JUMP_VELOCITY = -420.0
var allow_animation:bool = false
var leaved_floor: bool = false
var had_jump: bool = false
var max_jumps: int = 1
var count_jumps: int = 0
var double_jump: bool = false # en caso de usar en algun momento el doble salto
var ray_cast_dimesion = 14
var Tocar = false
var Tocar2 = false

func _ready():
	$AnimatedSprite2D.play("appear")
	$rayCast_walljump.target_position.x = ray_cast_dimesion
	
func _process(_delta):
	_Cambio2()

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		leaved_floor = false
		had_jump = false
		count_jumps = 0

	if not is_on_floor():
		if not leaved_floor:
			$Coyote_timer.start()
			leaved_floor = true
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("wasdUP") and right_to_jump():
		count_jumps += 1
		velocity.y = JUMP_VELOCITY
		$JumpBufferTimer.start()

	if right_to_jump() and !$JumpBufferTimer.is_stopped():
		count_jumps += 1
		velocity.y = JUMP_VELOCITY
	if !right_to_jump():
		count_jumps += 1 


	var direction := Input.get_axis("wasdL", "wasdR")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if $rayCast_walljump.get_collider():
		if $rayCast_walljump.get_collider().is_in_group("wall_jump"):
			if velocity.y >= 0:
				count_jumps = 1
				velocity.y = 135

	move_and_slide()
	decide_animation()
	
func decide_animation():
	if double_jump and velocity.x > 1:
		$AnimatedSprite2D.flip_h = true

	
	if double_jump:
		double_jump = false
		allow_animation = false
		$AnimatedSprite2D.play("doble_jump")
	if not allow_animation: return
	else:
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle")
		elif velocity.x < 0:
			$rayCast_walljump.target_position.x = -ray_cast_dimesion
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk")
		elif velocity.x > 0:
			$rayCast_walljump.target_position.x = ray_cast_dimesion
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk")
		
		if velocity.y > 0:
			$AnimatedSprite2D.play("jump")
		elif velocity.y < 0:
			$AnimatedSprite2D.play("fall")

func right_to_jump():
	if had_jump:
		if count_jumps < max_jumps: return true
		else: return false
	if is_on_floor():
		had_jump = true
		return true
	elif not $Coyote_timer.is_stopped():
		had_jump = true
		return true

func _on_animated_sprite_2d_animation_finished():
	allow_animation = true

func _on_coyote_timer_timeout():
	pass
	

func _Cambio2():
	if Tocar2 == true:
		set_physics_process(false)
		$AnimatedSprite2D.play("cambio2")
		await ($AnimatedSprite2D.animation_finished)
		Tocar2 = false
