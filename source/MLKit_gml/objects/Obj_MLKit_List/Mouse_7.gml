
mlkit_translation_get_downloaded_list(
    function(_success, _list_json, _error)
    {
        show_debug_message(
            "mlkit_translation_get_downloaded_list: "
            + json_stringify({
                success: _success,
                list: _list_json,
                error: _error
            })
        );

        if (_success)
        {
            var _languages = json_parse(_list_json);

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

