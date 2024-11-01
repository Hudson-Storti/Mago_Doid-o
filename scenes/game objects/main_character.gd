# Player.gd
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -850.0
@onready var sprite_2d = $Sprite2D
@onready var life_container = get_node("/root/Node/UI/Hearts/HBoxContainer")  # Ajuste o caminho se necessário

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var lives = 3
var checkpoint_position = Vector2()

func jump():
	velocity.y = JUMP_VELOCITY
	is_jumping = true

func jump_side(side_velocity: float):
	velocity.y = JUMP_VELOCITY * 0.5
	velocity.x = side_velocity

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		is_jumping = false

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, 15)

	update_animation()
	move_and_slide()

func update_animation():
	if is_jumping:
		sprite_2d.animation = "Jump"
	elif abs(velocity.x) > 1:
		sprite_2d.animation = "Run"
	else:
		sprite_2d.animation = "Walk"

# Função para diminuir uma vida e atualizar a HUD
func lose_life():
	lives -= 1
	life_container.update_lives(-1)  # Atualiza a HUD para refletir a perda de vida
	if lives > 0:
		position = checkpoint_position
	else:
		get_tree().change_scene("res://Menu.tscn")  # Volta para o menu ao perder todas as vidas
		print("Game Over")

func on_enemy_collision():
	lose_life()
	jump_side(-500 if position.x < checkpoint_position.x else 500)
