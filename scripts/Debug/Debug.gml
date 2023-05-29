#macro DEBUG true
function initDebug(){
	logD("initDebug")
}
function logD(){
	if(DEBUG){
		if(argument_count == 1){
			show_debug_message(argument[0])
		}else{
			var array = array_create(argument_count-1)
			for(var i = 0; i < argument_count - 1; i++){
				array[@ i] = string(argument[i + 1])
			}
			show_debug_message_ext(argument[0], array)
			array = -1
		}
	}
}
function logE(){
	if(argument_count == 1){
		show_debug_message(argument[0])
		throw argument[0]
	}else{
		var array = array_create(argument_count-1)
		for(var i = 0; i < argument_count - 1; i++){
			array[@ i] = string(argument[i + 1])
		}
		show_debug_message_ext(argument[0], array)
		throw string_ext(argument[0], array)
		array = -1
	}
}
initDebug()