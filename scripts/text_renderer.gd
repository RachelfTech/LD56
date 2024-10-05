class_name TextRenderer

extends CanvasLayer

@export var text_label: RichTextLabel
@export var text_container: MarginContainer
@export var audio_player: AudioStreamPlayer

var current_text: String
var current_text_list: Array[String] = []
var current_text_index: int = 0

var ready_animate_tween: Tween

var silent: bool = false

signal line_rendered
signal all_text_rendered

const BASE_TEXT_SPEED: float = 1.5
const AVERAGE_NUM_CHARS: float = 30.0

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
    _animate_in()

func advance_text() -> bool:
    if ready_animate_tween:
        ready_animate_tween.kill()
    print(ready_animate_tween.is_running())
    print("here")
    current_text_index += 1
    if current_text_list.size() <= current_text_index:
        print("done")
        return true
    text_label.visible_ratio = 0.0
    current_text = current_text_list[current_text_index]
    _animate_in()
    return false

func _animate_in():
    text_label.text = "[center]" + current_text + "[/center]"

    if not silent:
        audio_player.play()

    text_container.modulate = Color.TRANSPARENT
    var tween: Tween = get_tree().create_tween()
    tween.tween_property(text_container, "modulate", Color.WHITE, 1.5).set_trans(Tween.TRANS_SINE)
    tween.set_parallel()
    var num_chars: int = text_label.get_total_character_count()
    var tween_time: float = (num_chars / AVERAGE_NUM_CHARS) * BASE_TEXT_SPEED
    print(tween_time)
    tween.tween_property(text_label, "visible_ratio", 1, tween_time).set_trans(Tween.TRANS_LINEAR)

    await tween.finished
    line_rendered.emit()

    if current_text_index == current_text_list.size() - 1:
        all_text_rendered.emit()

func animate_ready():
    print("ready")
    ready_animate_tween = self.create_tween().set_loops()
    ready_animate_tween.tween_interval(1.5)
    ready_animate_tween.tween_property(text_container, "modulate:a", .75, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    ready_animate_tween.tween_interval(0)
    ready_animate_tween.tween_property(text_container, "modulate:a", 1, .8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
