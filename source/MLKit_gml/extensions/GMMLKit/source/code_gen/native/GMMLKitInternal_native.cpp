// ##### extgen :: Auto-generated file do not edit!! #####

#include "GMMLKitInternal_native.h"
#include "GMMLKitInternal_exports.h"

using namespace gm_structs;
using namespace gm::wire::codec;

static gm::runtime::DispatchQueue __dispatch_queue;

// Internal function used for fetching dispatched function calls to GML
GMEXPORT double __EXT_NATIVE__GMMLKit_invocation_handler(char* __ret_buffer, double __ret_buffer_length)
{
    gm::byteio::BufferWriter __bw{ __ret_buffer, static_cast<size_t>(__ret_buffer_length) };
    return __dispatch_queue.fetch(__bw);
}

GMEXPORT double __EXT_NATIVE__mlkit_translation_create(char* source, char* target)
{
    auto&& __result = mlkit_translation_create(source, target);
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__mlkit_translation_model_is_available(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: translator, type: Float64
    double translator = gm::wire::codec::readValue<double>(__br);

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    mlkit_translation_model_is_available(translator, callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__mlkit_translation_translate(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: translator, type: Float64
    double translator = gm::wire::codec::readValue<double>(__br);

    // field: text, type: String
    std::string_view text = gm::wire::codec::readValue<std::string_view>(__br);

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    mlkit_translation_translate(translator, text, callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__mlkit_translation_close(double translator)
{
    mlkit_translation_close(static_cast<double>(translator));
    return 0;
}

GMEXPORT double __EXT_NATIVE__mlkit_translation_get_downloaded_list(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    mlkit_translation_get_downloaded_list(callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__mlkit_translation_model_delete(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: language, type: String
    std::string_view language = gm::wire::codec::readValue<std::string_view>(__br);

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    mlkit_translation_model_delete(language, callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__mlkit_translation_model_download(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: language, type: String
    std::string_view language = gm::wire::codec::readValue<std::string_view>(__br);

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    mlkit_translation_model_download(language, callback);
    return 0;
}

