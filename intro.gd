extends Sequence

@export var animation_player: AnimationPlayer
@export var text_renderer: TextRenderer

var sequence_text: Array[String] = [
    "[center]I woke up one morning and you had [wave]changed....[/wave][/center]"]


var allow_advance: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    id = Globals.Sequences.INTRO

func start():
    text_renderer.set_sequence_text(sequence_text)
    animation_player.play("opening")
    animation_player.animation_finished.connect(_handle_animation_finished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func _input(_event: InputEvent) -> void:
    if allow_advance and Input.is_action_just_pressed("left-click"):
            var text_finished: bool = text_renderer.advance_text()
            if text_finished:
                finished.emit()

func _handle_animation_finished(_animation_name: String):
    allow_advance = true