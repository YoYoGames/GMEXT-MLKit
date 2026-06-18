// ##### extgen :: Auto-generated file do not edit!! #####

// #####################################################################
// # Macros
// #####################################################################

// #####################################################################
// # Enums
// #####################################################################

// #####################################################################
// # Constructors
// #####################################################################

// #####################################################################
// # Codecs
// #####################################################################

// #####################################################################
// # Functions
// #####################################################################

// Skipping function mlkit_translation_create (no wrapper is required)


/**
 * @param {Real} _translator
 * @param {Function} _callback
 */
function mlkit_translation_model_is_available(_translator, _callback)
{
    static __dispatcher = __GMMLKit_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _translator, type: Float64
    if (!is_numeric(_translator)) show_error($"{_GMFUNCTION_} :: _translator expected number", true);
    buffer_write(__args_buffer, buffer_f64, _translator);

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mlkit_translation_model_is_available(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {Real} _translator
 * @param {String} _text
 * @param {Function} _callback
 */
function mlkit_translation_translate(_translator, _text, _callback)
{
    static __dispatcher = __GMMLKit_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _translator, type: Float64
    if (!is_numeric(_translator)) show_error($"{_GMFUNCTION_} :: _translator expected number", true);
    buffer_write(__args_buffer, buffer_f64, _translator);

    // param: _text, type: String
    if (!is_string(_text)) show_error($"{_GMFUNCTION_} :: _text expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_text));
    buffer_write(__args_buffer, buffer_string, _text);

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mlkit_translation_translate(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function mlkit_translation_close (no wrapper is required)


/**
 * @param {Function} _callback
 */
function mlkit_translation_get_downloaded_list(_callback)
{
    static __dispatcher = __GMMLKit_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mlkit_translation_get_downloaded_list(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {String} _language
 * @param {Function} _callback
 */
function mlkit_translation_model_delete(_language, _callback)
{
    static __dispatcher = __GMMLKit_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _language, type: String
    if (!is_string(_language)) show_error($"{_GMFUNCTION_} :: _language expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_language));
    buffer_write(__args_buffer, buffer_string, _language);

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mlkit_translation_model_delete(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {String} _language
 * @param {Function} _callback
 */
function mlkit_translation_model_download(_language, _callback)
{
    static __dispatcher = __GMMLKit_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _language, type: String
    if (!is_string(_language)) show_error($"{_GMFUNCTION_} :: _language expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_language));
    buffer_write(__args_buffer, buffer_string, _language);

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mlkit_translation_model_download(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/// @ignore
function __GMMLKit_get_decoders()
{
    static __decoders = [];
    return __decoders;
}
/// @ignore
function __GMMLKit_get_dispatcher()
{
    static __dispatcher = new __GMNativeFunctionDispatcher(__GMMLKit_invocation_handler, __GMMLKit_get_decoders());
    return __dispatcher;
}
