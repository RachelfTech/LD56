class_name Sequence

extends Node


var id: Globals.Sequences

signal finished

func start():
    pass

func end():
    finished.emit()