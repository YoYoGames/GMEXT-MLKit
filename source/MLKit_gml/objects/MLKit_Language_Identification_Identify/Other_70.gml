

show_debug_message("async: " + json_encode(async_load));

switch(async_load[? "type"])
{
	case "mlkit_language_identification_identify":
	
	var success = async_load[? "success"];
	
		switch(success) {
		
		
			case -1: // Internal error!
				var error = async_load[? "error"];
			
			break;
			
			case 0: // Language undetermined!
			
			break;
			
			case 1: // Language determined.
				var languageCode = async_load[? "language_code"];
			
			break;
		
		}
	
	break;
	
}