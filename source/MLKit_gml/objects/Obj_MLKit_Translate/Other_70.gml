

show_debug_message("async: " + json_encode(async_load));

switch(async_load[? "type"])
{
	case "mlkit_translation_model_is_available":
	
		if (async_load[? "success"])
		{
			mlkit_translation_translate(translator, Obj_MLKit_Text_Source.text);
		}
		else
		{
			// Closing translator in each translation (not necessary)
			// It's recommended to do it once you dont need it more.
			mlkit_translation_close(translator);
		}
		break;
	
	case "mlkit_translation_translate":
	
		if (async_load[? "success"])
		{
			var _text = async_load[? "text"];
			
			Obj_MLKit_Text_Target.text = _text;
		}
		
		// Closing translator in each translation (not necessary)
		// It's recommended to do it once you dont need it more.
		mlkit_translation_close(translator);
		
		break;
		
	case "mlkit_translation_get_downloaded_list":
	
		if (async_load[? "success"])
		{
			var _list = async_load[? "list"];
			var _array = json_parse(_list);
			show_debug_message(_array);
			show_message_async(_array);
		}
		
		break;
	
	case "mlkit_translation_model_delete":
	
		var _str = async_load[? "success"] ? "Success" : "Failed";
		show_message_async("Delete " + async_load[? "language"] + ": " + _str);
		
		break;
	
	case "mlkit_translation_model_download":
	
		var _str = async_load[? "success"] ? "Success" : "Failed";
		show_message_async("Download " + async_load[? "language"] + ": " + _str);
		
		break;
	
}

