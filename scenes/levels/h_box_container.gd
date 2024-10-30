extends HBoxContainer

var max_lives = 3
var current_lives = max_lives
var lives_sprites = []

func _ready():
	# Inicializa as vidas
	for i in range(max_lives):
		var life_sprite = Sprite2D.new()  # Corrigido para usar Sprite2D
		life_sprite.texture = preload("res://assets/Free/Heartt.png")  # Ajuste o caminho para sua imagem
		life_sprite.position = Vector2(i * 32, 0)  # Ajuste a posição como necessário
		add_child(life_sprite)
		lives_sprites.append(life_sprite)

func update_lives(amount):
	current_lives = clamp(current_lives + amount, 0, max_lives)
	for i in range(max_lives):
		lives_sprites[i].visible = (i < current_lives)
