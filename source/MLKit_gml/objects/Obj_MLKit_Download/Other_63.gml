if (async_load[? "id"] != request)
{
    exit;
}

if (!async_load[? "status"])
{
    exit;
}

var _language = async_load[? "result"];

if (_language == "")
{
    exit;
}

mlkit_translation_model_download(
    _language,
    function(_success, _language, _error)
    {
        show_debug_message(
            "mlkit_translation_model_download: "
            + json_stringify({
                success: _success,
                language: _language,
                error: _error
            })
        );

        var _result = _success ? "Success" : "Failed";

        var _message =
            "Download " + _language + ": " + _result;

        if (!_success && _error != "")
        {
            _message += "\n" + _error;
        }

        show_message_async(_message);
    }
);