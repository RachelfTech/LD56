class_name TextRenderer

extends CanvasLayer

@export var text_label: RichTextLabel
@export var text_container: MarginContainer


var scene_text_strings: Array[String] = [
    "[center]One day I woke up and you had [wave]changed....[/wave][/center]",
]

var current_text: String = scene_text_strings[0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   # _animate_text()
    text_container.modulate = Color.TRANSPARENT
    text_label.visible_ratio = 0.0
    text_label.text = current_text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func fade_in():
    text_container.modulate = Color.TRANSPARENT
    var tween: Tween = get_tree().create_tween()
    tween.tween_property(text_container, "modulate", Color.WHITE, 1.5).set_trans(Tween.TRANS_SINE)
    tween.set_parallel()
    tween.tween_property(text_label, "visible_ratio", 1, 2).set_trans(Tween.TRANS_LINEAR)

func _animate_text():
    text_label.visible_ratio = 0.5