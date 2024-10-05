extends Node2D

@export var sequences_scenes: Array[PackedScene]

var current_sequence: Sequence

var current_sequence_index: int = 0
var sequence_finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    _start_sequence(sequences_scenes[current_sequence_index])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _start_next_sequence():
    current_sequence_index += 1
    if current_sequence_index >= sequences_scenes.size():
        print("finished all sequences")
        return
    var next_sequence: PackedScene = sequences_scenes[current_sequence_index]
    current_sequence.queue_free()
    _start_sequence(next_sequence)

func _start_sequence(sequence_scene: PackedScene):
    sequence_finished = false

    current_sequence = sequence_scene.instantiate()
    add_child(current_sequence)
    current_sequence.finished.connect(_handle_sequence_finished)
    #current_sequence.start()

func _handle_sequence_finished():
    print("sequence done")
    sequence_finished = true
    _start_next_sequence()

func _handle_text_renderer_finished_sequence():
    sequence_finished = true