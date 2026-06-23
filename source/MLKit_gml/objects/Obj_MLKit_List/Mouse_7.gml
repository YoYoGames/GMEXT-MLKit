
if (os_type != os_android && os_type != os_ios)
{
    show_message_async("ML Kit is only available on Android and iOS.");
    exit;
}

mlkit_translation_get_downloaded_list(
    function(_success, _list, _error)
    {
        show_debug_message(
            "mlkit_translation_get_downloaded_list: "
            + json_stringify({
                success: _success,
                list: _list,
                error: _error
            })
        );

        if (_success)
        {
            var _languages = _list;

            show_debug_message(_languages);
            show_message_async(json_stringify(_languages));
        }
        else
        {
            show_debug_message(
                "Failed to get downloaded ML Kit models: " + _error
            );

            show_message_async(
                "Failed to get downloaded models:\n" + _error
            );
        }
    }
);

