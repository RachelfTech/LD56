class_name TextRenderer

extends CanvasLayer

@export var text_label: RichTextLabel
@export var text_container: MarginContainer
@export var audio_player: AudioStreamPlayer

var current_text: String
var current_text_list: Array[String] = []
var current_text_index: int = 0

signal line_rendered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    text_container.modulate = Color.TRANSPARENT
    text_label.visible_ratio = 0.0
    text_label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func set_sequence_text(sequence_text: Array[String]):
    current_text_list = sequence_text

func play_text():
    current_text = current_text_list[current_text_index]
    animate_in()

func advance_text() -> bool:
    current_text_index += 1
    if current_text_list.size() <= current_text_index:
        print("done")
        return true
    text_label.visible_ratio = 0.0
    current_text = current_text_list[current_text_index]
    animate_in()
    return false

func animate_in():
    text_label.text = current_text

    audio_player.play()

    text_container.modulate = Color.TRANSPARENT
    var tween: Tween = get_tree().create_tween()
    tween.tween_property(text_container, "modulate", Color.WHITE, 1.5).set_trans(Tween.TRANS_SINE)
    tween.set_parallel()
    tween.tween_property(text_label, "visible_ratio", 1, 2).set_trans(Tween.TRANS_LINEAR)

    await tween.finished
    line_rendered.emit()