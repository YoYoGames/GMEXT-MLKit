
if(async_load[?"id"] == request)
if(async_load[?"status"])
if(async_load[?"result"] != "")
{
	var languaje = async_load[?"result"]
	mlkit_translation_model_download(languaje)
}

