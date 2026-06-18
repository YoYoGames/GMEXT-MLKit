// ##### extgen :: Auto-generated file do not edit!! #####

#pragma once
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

void mlkit_language_identification_identify(std::string_view text, const gm::wire::GMFunction& callback);
