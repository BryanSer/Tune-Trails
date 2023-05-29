/// @description Insert description here
// You can write your code in this editor
if(current_get_string_id == undefined) {
	return
}
var msgId = async_load[? "id"]
if(current_get_string_id == msgId){
	current_get_string_id = undefined
	var status = async_load[? "status"]
	if(status){
		var result =async_load[? "result"]
		if(on_input_callback != pointer_null) {
			if(on_input_callback(true, result)) {
				text = result
			}
		}
	} else {
		if(on_input_callback != pointer_null) {
			on_input_callback(false, pointer_null)
		}
	}
}
