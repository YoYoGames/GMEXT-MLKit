// FUNCTIONS

/**
 * @func mlkit_translation_create
 * @desc Creates a new translation unit for the given source and target languages and returns its unique identifier.
 *
 * [[Note: This function is only supported on **Android** and **iOS**.]]
 *
 * @param {String} source The source language tag (e.g. `"en"`).
 * @param {String} target The target language tag (e.g. `"es"`).
 * @returns {Real} The translation unit's unique identifier, or `-1` if the source|target language pair is not supported.
 *
 * @example
 * ```gml
 * translator = mlkit_translation_create("en", "es");
 * ```
 * @func_end
 */
function mlkit_translation_create(source, target) {}

/**
 * @func mlkit_translation_model_is_available
 * @desc Checks whether the translation model for the given translation unit is available, downloading the required language packages if needed. The result is delivered to the callback.
 *
 * [[Note: This function is only supported on **Android** and **iOS**.]]
 *
 * @param {Real} translator The unique identifier of the translation unit to check.
 * @param {Function} callback The function called with the result (see below).
 *
 * @event callback
 * @desc Triggered when the availability check completes.
 * @member {Bool} success Whether a translation model is available for the language pair.
 * @member {Real} translator The translator unique identifier.
 * @member {String|Undefined} error The error message, or `undefined` if the request succeeded.
 * @event_end
 *
 * @example
 * ```gml
 * mlkit_translation_model_is_available(translator, function(_success, _translator, _error) {
 *     if (_success) show_debug_message("Model available");
 * });
 * ```
 * @func_end
 */
function mlkit_translation_model_is_available(translator, callback) {}

/**
 * @func mlkit_translation_translate
 * @desc Requests the translation of the given text. The result is delivered to the callback.
 *
 * [[Note: This function is only supported on **Android** and **iOS**.]]
 *
 * @param {Real} translator The unique identifier of the translation unit to use.
 * @param {String} text The text to be translated.
 * @param {Function} callback The function called with the result (see below).
 *
 * @event callback
 * @desc Triggered when the translation request completes.
 * @member {Bool} success Whether the translation succeeded.
 * @member {Real} translator The translator unique identifier.
 * @member {String} text The translated text (empty on failure).
 * @member {String|Undefined} error The error message, or `undefined` if the request succeeded.
 * @event_end
 *
 * @example
 * ```gml
 * mlkit_translation_translate(translator, "Hello", function(_success, _translator, _text, _error) {
 *     if (_success) show_debug_message(_text);
 * });
 * ```
 * @func_end
 */
function mlkit_translation_translate(translator, text, callback) {}

/**
 * @func mlkit_translation_close
 * @desc Closes the translation unit and releases its resources.
 *
 * > [!WARNING]
 * > Should be called when the translation unit is no longer needed.
 *
 * @param {Real} translator The unique identifier of the translation unit to close.
 *
 * @example
 * ```gml
 * mlkit_translation_close(translator);
 * ```
 * @func_end
 */
function mlkit_translation_close(translator) {}

/**
 * @func mlkit_translation_get_downloaded_list
 * @desc Requests the list of all currently downloaded translation models. The result is delivered to the callback.
 *
 * [[Note: This function is only supported on **Android** and **iOS**.]]
 *
 * @param {Function} callback The function called with the result (see below).
 *
 * @event callback
 * @desc Triggered when the request completes.
 * @member {Bool} success Whether the request succeeded.
 * @member {Array<String>} list An array of the downloaded models' language tags (empty on failure).
 * @member {String|Undefined} error The error message, or `undefined` if the request succeeded.
 * @event_end
 *
 * @example
 * ```gml
 * mlkit_translation_get_downloaded_list(function(_success, _list, _error) {
 *     if (_success) show_debug_message(_list);
 * });
 * ```
 * @func_end
 */
function mlkit_translation_get_downloaded_list(callback) {}

/**
 * @func mlkit_translation_model_delete
 * @desc Requests the deletion of the provided translation model. The result is delivered to the callback.
 *
 * [[Note: This function is only supported on **Android** and **iOS**.]]
 *
 * @param {String} language The language model to be deleted.
 * @param {Function} callback The function called with the result (see below).
 *
 * @event callback
 * @desc Triggered when the deletion request completes.
 * @member {Bool} success Whether the deletion succeeded.
 * @member {String} language The language model that was targeted.
 * @member {String|Undefined} error The error message, or `undefined` if the request succeeded.
 * @event_end
 *
 * @example
 * ```gml
 * mlkit_translation_model_delete("es", function(_success, _language, _error) {
 *     show_debug_message("Delete " + _language + (_success ? ": ok" : ": " + _error));
 * });
 * ```
 * @func_end
 */
function mlkit_translation_model_delete(language, callback) {}

/**
 * @func mlkit_translation_model_download
 * @desc Requests the download of the provided translation model. The result is delivered to the callback.
 *
 * [[Note: This function is only supported on **Android** and **iOS**.]]
 *
 * @param {String} language The language model to be downloaded.
 * @param {Function} callback The function called with the result (see below).
 *
 * @event callback
 * @desc Triggered when the download request completes.
 * @member {Bool} success Whether the download succeeded.
 * @member {String} language The language model that was targeted.
 * @member {String|Undefined} error The error message, or `undefined` if the request succeeded.
 * @event_end
 *
 * @example
 * ```gml
 * mlkit_translation_model_download("es", function(_success, _language, _error) {
 *     show_debug_message("Download " + _language + (_success ? ": ok" : ": " + _error));
 * });
 * ```
 * @func_end
 */
function mlkit_translation_model_download(language, callback) {}

/**
 * @func mlkit_language_identification_identify
 * @desc Identifies the most likely language of the given text. The result is delivered to the callback.
 *
 * [[Note: This function is only supported on **Android** and **iOS**.]]
 *
 * @param {String} text The text whose language should be identified.
 * @param {Function} callback The function called with the result (see below).
 *
 * @event callback
 * @desc Triggered when the identification request completes.
 * @member {Constant.MLKitLanguageIdentificationStatus} status The outcome of the identification.
 * @member {String} language_code The identified BCP-47 language tag, or `"und"` if undetermined or on error.
 * @member {String|Undefined} error The error message, or `undefined` unless `status` is `MLKitLanguageIdentificationStatus.Error`.
 * @event_end
 *
 * @example
 * ```gml
 * mlkit_language_identification_identify("to be or not to be", function(_status, _language_code, _error) {
 *     if (_status == MLKitLanguageIdentificationStatus.Identified) {
 *         show_debug_message("Identified language: " + _language_code);
 *     }
 * });
 * ```
 * @func_end
 */
function mlkit_language_identification_identify(text, callback) {}

// CONSTANTS

/**
 * @const MLKitLanguageIdentificationStatus
 * @desc This enumeration contains the possible outcomes of a language identification request.
 * @member Error An internal ML Kit error occurred (see the `error` callback argument).
 * @member Undetermined The language could not be determined.
 * @member Identified The language was successfully identified.
 * @const_end
 */

// MODULES

/**
 * @module translation
 * @title Translation
 * @desc With ML Kit's on-device translation API, you can dynamically translate text between more than 50 languages.
 * @section_func
 * @desc The following functions are provided to work with the translation API:
 * @ref mlkit_translation_*
 * @section_end
 * @module_end
 */

/**
 * @module language_identification
 * @title Language Identification
 * @desc With ML Kit's on-device language identification API, you can determine the language of a string of text.
 * @section_func
 * @desc The following function is provided to work with the language identification API:
 * @ref mlkit_language_identification_*
 * @section_end
 * @section_const
 * @desc The following enumeration is used by the language identification API:
 * @ref MLKitLanguageIdentificationStatus
 * @section_end
 * @module_end
 */

/**
 * @module home
 * @title Home
 * @desc ML Kit brings Google’s machine learning expertise to mobile developers in a powerful and easy-to-use package. Make your iOS and Android apps more engaging, personalized, and helpful with solutions that are optimized to run on device.
 * @section Modules
 * @desc There are a great number of different functions related to the MLKit API. We've split them up into the following sections to make it easier to navigate:
 * @ref module.translation
 * @ref module.language_identification
 * @section_end
 * @module_end
 */
