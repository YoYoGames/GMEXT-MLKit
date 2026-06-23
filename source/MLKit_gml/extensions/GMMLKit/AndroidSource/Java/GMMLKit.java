package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;

import com.google.mlkit.common.model.DownloadConditions;
import com.google.mlkit.common.model.RemoteModelManager;
import com.google.mlkit.nl.translate.TranslateLanguage;
import com.google.mlkit.nl.translate.TranslateRemoteModel;
import com.google.mlkit.nl.translate.Translation;
import com.google.mlkit.nl.translate.Translator;
import com.google.mlkit.nl.translate.TranslatorOptions;

import java.util.HashMap;
import java.util.Set;

/*
 * Extension Generator implementation for the GMMLKit module.
 *
 * GMFunction is supplied by the generated Android binding.
 * All former Social Async events are returned through callback.call(...).
 *
 * Structured arrays are returned through GMExtWire.ArrayStream instead of
 * JSON strings.
 */
public class GMMLKit extends GMMLKitInternal
{
    private final HashMap<String, Translator> translators = new HashMap<>();
    private double nextTranslatorId = 0.0;

    public double mlkit_translation_create(String source, String target)
    {
        // Validate before building: setSourceLanguage/setTargetLanguage throw
        // IllegalArgumentException on an unsupported tag, which would crash the
        // app across JNI. fromLanguageTag returns null instead, so we can fail
        // gracefully with an invalid (-1) handle, matching iOS.
        String sourceLanguage = TranslateLanguage.fromLanguageTag(source);
        String targetLanguage = TranslateLanguage.fromLanguageTag(target);

        if (sourceLanguage == null || targetLanguage == null)
            return -1.0;

        TranslatorOptions options = new TranslatorOptions.Builder()
            .setSourceLanguage(sourceLanguage)
            .setTargetLanguage(targetLanguage)
            .build();

        Translator translator = Translation.getClient(options);
        nextTranslatorId += 1.0;
        translators.put(key(nextTranslatorId), translator);
        return nextTranslatorId;
    }

    public void mlkit_translation_model_is_available(
        final double translatorId,
        final GMFunction callback)
    {
        Translator translator = translators.get(key(translatorId));
        if (translator == null)
        {
            callback.call(false, translatorId, "Invalid translator handle.");
            return;
        }

        DownloadConditions conditions =
            new DownloadConditions.Builder().requireWifi().build();

        translator.downloadModelIfNeeded(conditions)
            .addOnSuccessListener(unused ->
                callback.call(true, translatorId, ""))
            .addOnFailureListener(error ->
                callback.call(false, translatorId, message(error)));
    }

    public void mlkit_translation_translate(
        final double translatorId,
        String text,
        final GMFunction callback)
    {
        Translator translator = translators.get(key(translatorId));
        if (translator == null)
        {
            callback.call(false, translatorId, "", "Invalid translator handle.");
            return;
        }

        translator.translate(text)
            .addOnSuccessListener(translatedText ->
                callback.call(true, translatorId, translatedText, ""))
            .addOnFailureListener(error ->
                callback.call(false, translatorId, "", message(error)));
    }

    public void mlkit_translation_close(double translatorId)
    {
        Translator translator = translators.remove(key(translatorId));
        if (translator != null)
            translator.close();
    }

    public void mlkit_translation_get_downloaded_list(final GMFunction callback)
    {
        RemoteModelManager.getInstance()
            .getDownloadedModels(TranslateRemoteModel.class)
            .addOnSuccessListener(models ->
                callback.call(true, modelsToArray(models), ""))
            .addOnFailureListener(error ->
                // Known-empty result: a tiny header-only buffer is enough.
                callback.call(false, new GMExtWire.ArrayStream(16), message(error)));
    }

    public void mlkit_translation_model_delete(
        final String language,
        final GMFunction callback)
    {
        TranslateRemoteModel model =
            new TranslateRemoteModel.Builder(language).build();

        RemoteModelManager.getInstance()
            .deleteDownloadedModel(model)
            .addOnSuccessListener(unused ->
                callback.call(true, language, ""))
            .addOnFailureListener(error ->
                callback.call(false, language, message(error)));
    }

    public void mlkit_translation_model_download(
        final String language,
        final GMFunction callback)
    {
        TranslateRemoteModel model =
            new TranslateRemoteModel.Builder(language).build();

        DownloadConditions conditions =
            new DownloadConditions.Builder().requireWifi().build();

        RemoteModelManager.getInstance()
            .download(model, conditions)
            .addOnSuccessListener(unused ->
                callback.call(true, language, ""))
            .addOnFailureListener(error ->
                callback.call(false, language, message(error)));
    }

    private static String key(double translatorId)
    {
        return String.valueOf(translatorId);
    }

    private static String message(Exception error)
    {
        if (error == null)
            return "Unknown ML Kit error.";

        String value = error.getMessage();
        return value != null ? value : error.toString();
    }

    private static GMExtWire.ArrayStream modelsToArray(
        Set<TranslateRemoteModel> models)
    {
        // Default capacity; the buffer grows as languages are appended.
        GMExtWire.ArrayStream languages = new GMExtWire.ArrayStream();

        if (models == null)
            return languages;

        for (TranslateRemoteModel model : models)
        {
            if (model == null)
                continue;

            String language = model.getLanguage();

            if (language != null)
                languages.add(language);
        }

        return languages;
    }
}
