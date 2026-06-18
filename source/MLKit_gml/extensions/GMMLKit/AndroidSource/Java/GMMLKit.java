package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.GMExtUtils;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.enums.*;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.common.model.DownloadConditions;
import com.google.mlkit.common.model.RemoteModelManager;
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
 */
public class GMMLKit extends GMMLKitInternal
{
    private final HashMap<String, Translator> translators = new HashMap<>();
    private double nextTranslatorId = 0.0;

    public double mlkit_translation_create(String source, String target)
    {
        TranslatorOptions options = new TranslatorOptions.Builder()
            .setSourceLanguage(source)
            .setTargetLanguage(target)
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
                callback.call(true, modelsToJson(models), ""))
            .addOnFailureListener(error ->
                callback.call(false, "[]", message(error)));
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
        String value = error.getMessage();
        return value != null ? value : error.toString();
    }

    private static String modelsToJson(Set<TranslateRemoteModel> models)
    {
        StringBuilder json = new StringBuilder("[");
        boolean first = true;

        for (TranslateRemoteModel model : models)
        {
            if (!first)
                json.append(',');

            json.append('"')
                .append(escapeJson(model.getLanguage()))
                .append('"');

            first = false;
        }

        return json.append(']').toString();
    }

    private static String escapeJson(String value)
    {
        if (value == null)
            return "";

        return value
            .replace("\\", "\\\\")
            .replace("\"", "\\\"");
    }
}
