
if (os_type != os_android && os_type != os_ios)
{
    show_message_async("ML Kit is only available on Android and iOS.");
    exit;
}

translator = mlkit_translation_create(
    Obj_MLKit_Language_Source.text,
    Obj_MLKit_Language_Target.text
);

mlkit_translation_model_is_available(
    translator,
    function(_success, _translator, _error)
    {
        show_debug_message(
            "mlkit_translation_model_is_available: "
            + json_stringify({
                success: _success,
                translator: _translator,
                error: _error
            })
        );

        if (_success)
        {
            mlkit_translation_translate(
                _translator,
                Obj_MLKit_Text_Source.text,
                function(_success, _translator, _text, _error)
                {
                    show_debug_message(
                        "mlkit_translation_translate: "
                        + json_stringify({
                            success: _success,
                            translator: _translator,
                            text: _text,
                            error: _error
                        })
                    );

                    if (_success)
                    {
                        Obj_MLKit_Text_Target.text = _text;
                    }
                    else
                    {
                        show_debug_message(
                            "ML Kit translation failed: " + _error
                        );
                    }

                    // Closing the translator after every translation is
                    // optional. It is better to keep it open when it will
                    // be used again with the same language pair.
                    mlkit_translation_close(_translator);
                }
            );
        }
        else
        {
            show_debug_message(
                "ML Kit model availability failed: " + _error
            );

            mlkit_translation_close(_translator);
        }
    }
);

