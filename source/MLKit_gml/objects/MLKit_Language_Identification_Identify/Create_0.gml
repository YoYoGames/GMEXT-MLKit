
mlkit_language_identification_identify(
    "to be or not to be, that's the question.",
    function(_status, _language_code, _error)
    {
        show_debug_message(
            "mlkit_language_identification_identify: "
            + json_stringify({
                status: _status,
                language_code: _language_code,
                error: _error
            })
        );

        switch (_status)
        {
            case MLKitLanguageIdentificationStatus.Error:
                // Internal ML Kit error.
                show_debug_message(
                    "Language identification error: " + _error
                );
            break;

            case MLKitLanguageIdentificationStatus.Undetermined:
                // ML Kit could not determine the language.
                show_debug_message(
                    "Language could not be determined."
                );
            break;

            case MLKitLanguageIdentificationStatus.Identified:
                // Language was successfully identified.
                show_debug_message(
                    "Identified language: " + _language_code
                );
            break;
        }
    }
);

