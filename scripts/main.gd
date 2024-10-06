extends Node2D

@export var sequences_scenes: Array[PackedScene]

var current_sequence: Sequence

var current_sequence_index: int = 0
var sequence_finished: bool = false

@export var main_theme: AudioStreamPlayer
@export var ominious: AudioStreamPlayer
@export var end_theme: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    _start_sequence(sequences_scenes[current_sequence_index])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _start_next_sequence():
    current_sequence_index += 1
    if current_sequence_index >= sequences_scenes.size():
        end_theme.stop()
        main_theme.play()
        current_sequence_index = 0
    var next_sequence: PackedScene = sequences_scenes[current_sequence_index]

    # Disconnect the end signal so it can't fire before the sequence is queue_free'd.
    current_sequence.finished.disconnect(_handle_sequence_finished)
    current_sequence.queue_free()

    if current_sequence_index == 6:
        main_theme.stop()
        ominious.play()

    if current_sequence_index == 7:
        main_theme.stop()
        ominious.stop()
        end_theme.play()

    _start_sequence(next_sequence)

func _start_sequence(sequence_scene: PackedScene):
    sequence_finished = false

    current_sequence = sequence_scene.instantiate()
    add_child(current_sequence)
    current_sequence.finished.connect(_handle_sequence_finished)

func _handle_sequence_finished():
    sequence_finished = true
    _start_next_sequence()

func _handle_text_renderer_finished_sequence():
    sequence_finished = true