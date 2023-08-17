function forEach(data, func){
	if(is_array(data)){
		for(var i = 0; i < array_length(data); i++){
			func(data[i])
		}
	}else if(is_struct(data)){
		var names = variable_struct_get_names(data)
		var length = array_length(names)
		for(var i = 0; i < length; i++) {
			var name = names[i]
			var obj = data[$ name]
			func(name, ob)
		}
	} else if(ds_exists(data, ds_type_map)){
		var keys = ds_map_keys_to_array(data)
		for(var i = 0; i < array_length(keys); i++){
			var key = keys[i]
			var value = data[? key]
			func(key, value)
		}
	} else if(ds_exists(data, ds_type_stack)){
		if(!ds_stack_empty(data)){
			var copy = ds_stack_create()
			ds_stack_copy(copy, data)
			while(!ds_stack_empty(copy)){
				var obj = ds_stack_pop(copy)
				func(obj)
			}
			ds_stack_destroy(copy)
		}

	} else if(ds_exists(data, ds_type_list)){
		for(var i = 0; i < ds_list_size(data); i++){
			func(data[| i])
		}
	} else {
		logE("不支持ForEach的数据 {0}", data)
	}
}
