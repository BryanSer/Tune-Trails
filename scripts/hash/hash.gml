

function hash(){
	var buffer = buffer_create(argument_count, buffer_grow, 1)
	for(var i = 0; i < argument_count; i++){
		var data = argument[i]
		hashWithBuffer(buffer, data)
	}
	var result = buffer_md5(buffer, 0, buffer_get_size(buffer))
	buffer_delete(buffer)
	return result
}

function hashWithBuffer(buffer, data){
	var type = undefined
	switch(typeof(data)){
		case "number":
			type = buffer_f64
			break
		case "string":
			type = buffer_string
			break
		case "array":
			buffer_write(buffer, buffer_string, string("h__array_{0}", array_length(data)))
			forEach(data, method({buffer:buffer}, function(item){
				hashWithBuffer(buffer, item)
			}))
			return
			break
		case "ptr":
		case "ref":
			type = buffer_string
			data = string(data)
			break
		case "bool":
			type = buffer_bool
			break
		case "int32":
			type = buffer_s32
			break
		case "int64":
			type = buffer_f64
			break
		case "undefined":
			buffer_write(buffer, buffer_string, "h__undefined")
			return
			break
		case "null":
			buffer_write(buffer, buffer_string, "h__null")
			return
			break
		case "struct":
			buffer_write(buffer, buffer_string, string("h__struct"))
			forEach(data, method({buffer:buffer}, function(k,v){
				buffer_write(buffer, buffer_string, k)
				hashWithBuffer(buffer, v)
			}))
			return
			break
		case "unknown":
			buffer_write(buffer, buffer_string, "h__unknown")
			return
			break
			
	}
	
	if(type == undefined){
		logE("hash error, unknow data: {0}", data)
	}
	buffer_write(buffer, type, data)
}