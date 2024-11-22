extends Node

@onready var points_label: Label = %PointsLabel
@export var hearts: Array[Node]
var points = 0
var lives = 3

# Referência para o nó AudioStreamPlayer
@onready var audio_player: AudioStreamPlayer = $Audio/playmusic/AudioStreamPlayer
# Lista de músicas
var playlist = [
	"res://assets/Free/Music/Xuxa - Especial Estátua 20 anos.mp3",
	"res://assets/Free/Music/Vida loka parte 1 - Racionais Mcs.mp3",
	"res://assets/Free/Music/Maneol Gomes - Caneta Azul.mp3",
	"res://assets/Free/Music/Crazy Frog - Axel F (Official Video).mp3",
	"res://assets/Free/Music/Eu Sou O Gummy Bear - Gummy Bear Song Brazilian Osito Gominola Brazil Som Livre Brasil.mp3",
	"res://assets/Free/Music/Mc Sid , Nog - Sítio do Tio Harry (Animação Oficial) - Prod Nine e Chiocki.mp3",
	"res://assets/Free/Music/Mamonas Assassinas - Pelados em Santos (Videoclipe).mp3"
]

var current_track = 0  # Índice da música atual na playlist

func _ready():
	# Verifica se o nó `audio_player` foi encontrado
	if not audio_player:
		print("Erro: O nó AudioStreamPlayer não foi encontrado! Verifique o caminho.")
		return

	# Tenta carregar e reproduzir a primeira música
	_play_current_track()

func _play_current_track():
	# Certifica-se de que o nó audio_player é válido
	if not audio_player:
		print("Erro: O nó AudioStreamPlayer não foi encontrado!")
		return

	# Carrega o arquivo de áudio
	var stream = load(playlist[current_track])
	if stream is AudioStream:
		audio_player.stream = stream
		audio_player.play()
		print("Reproduzindo:", playlist[current_track])
	else:
		print("Erro: O arquivo carregado não é válido ou não é um AudioStream.")

# Botão Play
func _on_playmusic_pressed() -> void:
	if audio_player and not audio_player.playing:
		audio_player.play()

# Botão Pause
func _on_pausemusic_pressed() -> void:
	if audio_player and audio_player.playing:
		audio_player.stop()

# Botão Avançar
func _on_rightmusic_pressed() -> void:
	current_track = (current_track + 1) % playlist.size()
	_play_current_track()

# Botão Retroceder
func _on_leftmusic_pressed() -> void:
	current_track = (current_track - 1 + playlist.size()) % playlist.size()
	_play_current_track()

# Função de vida
func decrease_health():
	lives -= 1
	print(lives)
	for h in range(3):
		if h < lives:
			hearts[h].show()
		else:
			hearts[h].hide()
	if lives == 0:
		get_tree().reload_current_scene()

# Função de pontos
func add_point():
	points += 1
	print(points)
	points_label.text = "Pontos: " + str(points)
