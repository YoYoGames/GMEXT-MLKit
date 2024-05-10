// FUNCTIONS

/**
 * @func mlkit_translation_create
 * @desc Creates a new translation unit.
 * @returns {real}
 * @func_end
 */
function mlkit_translation_create(source, target) {}

/** 
 * @func mlkit_translation_model_is_available
 * @desc Try to install the language packages required for the translation model to work. This function returns the request ID.
 * @returns {real}
 * 
 * @event social
 * @member {string} type The value `"mlkit_translation_model_is_available"`
 * @member {real} success Whether there is a translation model available for the source|target language
 * @member {real} translator The translator unique identifier
 * @event_end

 * @func_end
 */
function mlkit_translation_model_is_available() {}

/** 
 * @func mlkit_translation_translate
 * @desc Requests the translation of the given input text. This function returns the request ID.
 * @param {real} translation_unit The unique id of the translion unit to be used.
 * @param {string} text The text to be translated
 * @returns {real}
 * 
 * @event social
 * @desc When a translation succeeds:
 * @member {string} type The value `"mlkit_translation_translate"`
 * @member {real} success The value `1`
 * @member {real} translator The translator unique identifier
 * @member {string} text The translated text
 * @event_end
 * 
 * @event social
 * @desc When a translation fails:
 * @member {string} type The value `"mlkit_translation_translate"`
 * @member {real} success The value `0`
 * @member {real} translator The translator unique identifier
 * @member {string} error The error message
 * @event_end
 * 
 * @func_end
 */
function mlkit_translation_translate(translation_unit, text) {}

/** 
 * @func mlkit_translation_close
 * @desc Closes the translation unit and releases its resources.
 * 
 * > [!WARNING]
 * > Should be called when the translation unit is no longer needed.
 * 
 * @param {real} translation_unit The unique id of the translation unit to be closed.
 * @func_end
 */
function mlkit_translation_close(translation_unit) {}

/** 
 * @func mlkit_translation_get_downloaded_list
 * @desc Requests the list of all currently downloaded translation models. This function returns the request ID.
 * @returns {real}
 * 
 * @event social
 * @desc When the request succeeds:
 * @member {string} type The value `"mlkit_translation_get_downloaded_list"`
 * @member {real} success The value `1`
 * @member {string} list The JSON formatted array of the downloaded models
 * @event_end
 * 
 * @event social
 * @desc When the request fails:
 * @member {string} type The value `"mlkit_translation_get_downloaded_list"`
 * @member {real} success The value `0`
 * @member {string} error The error message
 * @event_end
 * 
 * @func_end
 */
function mlkit_translation_get_downloaded_list() {}

/** 
 * @func mlkit_translation_model_delete
 * @desc Requests the deletion of the provided translation model. This function returns the request ID.
 * @param {string} language The language model to be deleted
 * @returns {real}
 * 
 * @event social
 * @desc When the request succeeds:
 * @member {string} type The value `"mlkit_translation_model_delete"`
 * @member {real} success The value `1`
 * @member {string} language The deleted language model
 * @event_end
 * 
 * @event social
 * @desc When the request fails:
 * @member {string} type The value `"mlkit_translation_model_delete"`
 * @member {real} success The value `0`
 * @member {string} error The error message
 * @event_end
 * 
 * @func_end
 */
function mlkit_translation_model_delete(language) {}

/** 
 * @func mlkit_translation_model_download
 * @desc Requests the download of the provided translation model. This function returns the request ID.
 * @param {string} language The language model to be downloaded
 * @returns {real}
 * 
 * @event social
 * @desc When the request succeeds:
 * @member {string} type The value `"mlkit_translation_model_download"`
 * @member {real} success The value `1`
 * @member {string} language The downloaded language model
 * @event_end
 * 
 * @event social
 * @desc When the request fails:
 * @member {string} type The value `"mlkit_translation_model_download"`
 * @member {real} success The value `0`
 * @member {string} error The error message
 * @event_end
 * 
 * @func_end
 */
function mlkit_translation_model_download(language) {}

/** 
 * @module translation
 * @title Translation
 * @desc With ML Kit's on-device translation API, you can dynamically translate text between more than 50 languages.
 * @section_func
 * @ref mlkit_translation_*
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
 * @section_end
 * @module_end
 */

