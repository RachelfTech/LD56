extends Node2D

@export var text_renderer: TextRenderer
@export var animation_player: AnimationPlayer

var current_sequence_index: int = 0
var sequences: Array[Globals.Sequences] = [Globals.Sequences.INTRO, Globals.Sequences.SECOND]
var sequence_finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    _start_sequence(sequences[current_sequence_index])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("left-click"):
            sequence_finished = text_renderer.advance_text()
            if sequence_finished:
                _start_next_sequence()

func _start_next_sequence():
    current_sequence_index += 1
    if current_sequence_index >= sequences.size():
        print("finished all sequences")
        return
    var next_sequence: Globals.Sequences = sequences[current_sequence_index]
    _start_sequence(next_sequence)

func _start_sequence(sequence: Globals.Sequences):
    sequence_finished = false
    text_renderer.start_sequence(sequence)
    if animation_player.has_animation(Globals.sequence_animations[sequence]):
        animation_player.play(Globals.sequence_animations[sequence])
    else:
        print("no animation for sequence")

func _handle_text_renderer_finished_sequence():
    sequence_finished = true