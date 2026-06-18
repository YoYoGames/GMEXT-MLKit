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

double mlkit_translation_create(std::string_view source, std::string_view target);
void mlkit_translation_model_is_available(double translator, const gm::wire::GMFunction& callback);
void mlkit_translation_translate(double translator, std::string_view text, const gm::wire::GMFunction& callback);
void mlkit_translation_close(double translator);
void mlkit_translation_get_downloaded_list(const gm::wire::GMFunction& callback);
void mlkit_translation_model_delete(std::string_view language, const gm::wire::GMFunction& callback);
void mlkit_translation_model_download(std::string_view language, const gm::wire::GMFunction& callback);
