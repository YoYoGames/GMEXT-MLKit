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
    enum class MLKitLanguageIdentificationStatus : std::int32_t
    {
        Error = -1,
        Undetermined = 0,
        Identified = 1
    };

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

@protocol GMMLKitLanguageIdentificationInterface <NSObject>
- (void)mlkit_language_identification_identify:(std::string_view)text callback:(gm::wire::GMFunction)callback;
@end


@interface GMMLKitLanguageIdentificationInternal : NSObject
- (double)__EXT_NATIVE__mlkit_language_identification_identify:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__GMMLKitLanguageIdentification_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length;
@end


