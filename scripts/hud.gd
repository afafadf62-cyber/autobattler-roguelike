extends CanvasLayer
## HUD.gd - Main HUD and UI system

@onready var gold_label = Label.new()
@onready var wave_label = Label.new()
@onready var wave_message_timer = 0.0

func _ready() -> void:
	# Setup gold label
	gold_label.position = Vector2(10, 10)
	gold_label.text = "Gold: 0"
	gold_label.add_theme_font_size_override("font_size", 24)
	add_child(gold_label)
	
	# Setup wave label
	wave_label.position = Vector2(get_viewport_rect().size.x / 2 - 100, 50)
	wave_label.text = "Wave 1"
	wave_label.add_theme_font_size_override("font_size", 32)
	wave_label.modulate.a = 0.0
	add_child(wave_label)

func _process(delta: float) -> void:
	# Fade out wave message
	if wave_message_timer > 0:
		wave_message_timer -= delta
		wave_label.modulate.a = wave_message_timer / 2.0

## Update gold display
func update_gold_display(gold: int) -> void:
	gold_label.text = "Gold: %d" % gold

## Show wave message
func show_wave_message(message: String) -> void:
	wave_label.text = message
	wave_label.modulate.a = 1.0
	wave_message_timer = 2.0
