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

@onready var heart1 = $Heart
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3


# Atualiza os corações visíveis com base no número de vidas
func update_lives(lives: int):
    # Atualiza a visibilidade dos corações com base no número de vidas restantes
    heart1.visible = lives >= 1
    heart2.visible = lives >= 2
    heart3.visible = lives >= 3
