class_name TextRenderer

extends CanvasLayer

@export var text_label: RichTextLabel
@export var text_container: MarginContainer
@export var audio_player: AudioStreamPlayer


var scene_text_strings: Dictionary = {
    Globals.Sequences.INTRO: ["[center]I woke up one morning and you had [wave]changed....[/wave][/center]"],
    Globals.Sequences.SECOND: ["I can't believe it actually happened.",
            "But I wanted to make things work...",
            "So I did everything I could"]
}

var current_text: String
var current_text_list: Array = []
var current_text_index: int = 0
var current_scene: Globals.Sequences


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    text_container.modulate = Color.TRANSPARENT
    text_label.visible_ratio = 0.0
    text_label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func start_sequence(scene: Globals.Sequences):
    current_scene = scene
    current_text_list = scene_text_strings[current_scene]
    current_text_index = 0

    current_text = current_text_list[current_text_index]
    print(current_text)

func play_text():
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
