// ##### extgen :: Auto-generated file do not edit!! #####

#pragma once
#import <Foundation/Foundation.h>

#include <cstdint>
#include <string_view>
#include <vector>
#include <array>
#include <optional>
#include "core/GMExtWire.h"

namespace gm_consts
{
}


namespace gm_enums
{
}


namespace gm_structs
{

}

namespace gm::wire::codec
{
}

namespace gm::wire::details
{
}

@protocol GMMLKitInterface <NSObject>
- (double)mlkit_translation_create:(std::string_view)source target:(std::string_view)target;
- (void)mlkit_translation_model_is_available:(double)translator callback:(gm::wire::GMFunction)callback;
- (void)mlkit_translation_translate:(double)translator text:(std::string_view)text callback:(gm::wire::GMFunction)callback;
- (void)mlkit_translation_close:(double)translator;
- (void)mlkit_translation_get_downloaded_list:(gm::wire::GMFunction)callback;
- (void)mlkit_translation_model_delete:(std::string_view)language callback:(gm::wire::GMFunction)callback;
- (void)mlkit_translation_model_download:(std::string_view)language callback:(gm::wire::GMFunction)callback;
@end


@interface GMMLKitInternal : NSObject
- (double)__EXT_NATIVE__mlkit_translation_create:(char*)source arg1:(char*)target;
- (double)__EXT_NATIVE__mlkit_translation_model_is_available:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__mlkit_translation_translate:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__mlkit_translation_close:(double)translator;
- (double)__EXT_NATIVE__mlkit_translation_get_downloaded_list:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__mlkit_translation_model_delete:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__mlkit_translation_model_download:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__GMMLKit_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length;
@end


