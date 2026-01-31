# from https://github.com/godotengine/godot-demo-projects/blob/master/2d/finite_state_machine/state_machine

extends Node2D
class_name StateMachine
# Base interface for a generic state machine.
# It handles initializing, setting the machine active or not
# delegating _physics_process, _input calls to the State nodes,
# and changing the current/active state.
# See the PlayerV2 scene for an example on how to use it.

signal state_changed(current_state: Node)

@export var initial_state: State

var current_state: State = null
var state_map: Dictionary = {}


func _enter_tree() -> void:
	for child in get_children():
		if child is State:
			state_map[child.name] = child
			child.finished.connect(change_state)
	
	if initial_state:
		change_state(initial_state.name)

func _unhandled_input(input_event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(input_event)

func _ready() -> void:
	for state in state_map.values():
		state.ready()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _on_animation_finished(anim_name: String) -> void:
	if current_state:
		current_state._on_animation_finished(anim_name)

func change_state(state_name: String) -> void:
	var new_state = state_map.get(state_name)
	if new_state == null: return
	
	if current_state != null:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
	
	state_changed.emit(current_state)
