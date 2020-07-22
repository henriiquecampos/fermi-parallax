extends ProgressBar


export var resource_path: NodePath

onready var resource: ActionResource = get_node_or_null(resource_path) setget set_resource


func _ready() -> void:
	if resource:
		link_resource()


func set_resource(new_resource: ActionResource) -> void:
	resource = new_resource
	link_resource()


func link_resource() -> void:
	if not resource.is_connected("changed", self, "set_value"):
		resource.connect("changed", self, "set_value")
	if not resource.is_connected("max_changed", self, "set_max"):
		resource.connect("max_changed", self, "set_max")
	resource.initialize()
