extends CharacterBody2D
class_name Player

const SPEED = 300.0
var transition_input_locked: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


