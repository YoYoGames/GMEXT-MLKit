
if (os_type != os_android && os_type != os_ios)
{
    show_message_async("ML Kit is only available on Android and iOS.");
    exit;
}

request = get_string_async("Language pack to delete:", "fr");
