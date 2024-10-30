extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -850.0
@onready var sprite_2d = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false  # Controla se o personagem está no ar

func jump():
	velocity.y = JUMP_VELOCITY
	is_jumping = true  # Marca que o personagem iniciou um pulo

func _physics_process(delta: float) -> void:
	# Aplicando gravidade se não estiver no chão
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Ao tocar o chão, o personagem não está mais pulando
		is_jumping = false

	# Pular se a tecla Jump (Espaço ou W) for pressionada e o player estiver no chão
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()

	# Movimentação lateral com AWSD e Setas
	var direction := Input.get_axis("ui_left", "ui_right")
	print("Direction: ", direction)  # Adicione esta linha para debugar
	if direction != 0:
		velocity.x = direction * SPEED
		sprite_2d.flip_h = direction < 0  # Troca direção do sprite
	else:
		velocity.x = move_toward(velocity.x, 0, 15)  # Suaviza a parada

	# Atualiza a animação
	update_animation()

	# Movimenta o personagem e lida com colisões
	move_and_slide()

func update_animation():
	if is_jumping:
		sprite_2d.animation = "Jump"  # Animação de pulo
	elif abs(velocity.x) > 1:
		sprite_2d.animation = "Run"  # Animação de correr
	else:
		sprite_2d.animation = "Walk"  # Animação de andar/parado
