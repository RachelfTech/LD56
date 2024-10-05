extends Node

enum Sequences {
    INTRO,
    SECOND,
}

var sequence_animations: Dictionary = {
    Sequences.INTRO: "opening",
    Sequences.SECOND: "second",
}