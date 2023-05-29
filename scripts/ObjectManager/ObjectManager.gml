// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initObjectManager(){
	global.ObjectManager = {
		objectMap: ds_map_create(),
		/// @function registerObject(nameSpace, name, obj) 注册对象到管理器
		/// @param {constant.ObjectNameSpace} nameSpace ObjectNameSpace
		/// @param {string} name
		/// @param {any} obj
		registerObject: function(nameSpace, name, obj) {
			var objName = getObjectName(nameSpace, name)
			self.objectMap[? objName] = obj
		},
		/// @function get(nameSpace, name, obj) 从管理器里读取对象
		/// @param {constant.ObjectNameSpace} nameSpace
		/// @param {string} name
		/// @return {any}
		get: function(nameSpace, name) {
			var objName = getObjectName(nameSpace, name)
			if(!ds_map_exists(self.objectMap, objName)){
				logE("找不到对象: {0}", objName)
			}else{
				return self.objectMap[? objName]
			}
		}
	}
}

function getObjectName(nameSpace, name){
	return string("{0}.{1}", nameSpace, name)
}