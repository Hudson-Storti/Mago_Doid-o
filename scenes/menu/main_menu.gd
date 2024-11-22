extends Node

func _on_votar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_home.tscn")
	
func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
	
func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
	
func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")
	
func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level4.tscn")
	
	# Referência para o nó AudioStreamPlayer
@onready var audio_player = $Audio/playmusic/AudioStreamPlayer

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
	# Carrega a primeira música
	audio_player.stream = load(playlist[current_track])
	audio_player.play()

# Botão Play
func _on_playmusic_pressed() -> void:
	if not audio_player.playing:
		audio_player.play()

# Botão Pause
func _on_pausemusic_pressed() -> void:
	if audio_player.playing:
		audio_player.stop()
		
# Botão Avançar
func _on_rightmusic_pressed() -> void:
	current_track = (current_track + 1) % playlist.size()
	_play_current_track()

# Botão Retroceder
func _on_leftmusic_pressed() -> void:
	current_track = (current_track - 1) % playlist.size()
	_play_current_track()

# Reproduz a música atual
func _play_current_track():
	audio_player.stream = load(playlist[current_track])
	audio_player.play()
