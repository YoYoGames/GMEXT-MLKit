package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.GMExtUtils;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.enums.*;

import com.google.mlkit.nl.languageid.LanguageIdentification;
import com.google.mlkit.nl.languageid.LanguageIdentifier;

/*
 * Extension Generator implementation for GMMLKitLanguageIdentification.
 *
 * callback(status, language_code, error)
 */
public class GMMLKitLanguageIdentification
    extends GMMLKitLanguageIdentificationInternal
{
    private static final int STATUS_ERROR = -1;
    private static final int STATUS_UNDETERMINED = 0;
    private static final int STATUS_IDENTIFIED = 1;
    private static final String UNDETERMINED = "und";

    public void mlkit_language_identification_identify(
        String text,
        final GMFunction callback)
    {
        LanguageIdentifier identifier = LanguageIdentification.getClient();

        identifier.identifyLanguage(text)
            .addOnSuccessListener(languageCode ->
            {
                // Omit the trailing error arg when there is no error; it
                // arrives as undefined on the GML side.
                if (UNDETERMINED.equals(languageCode))
                    callback.call(STATUS_UNDETERMINED, UNDETERMINED);
                else
                    callback.call(STATUS_IDENTIFIED, languageCode);

                identifier.close();
            })
            .addOnFailureListener(error ->
            {
                String message = error.getMessage();
                callback.call(
                    STATUS_ERROR,
                    UNDETERMINED,
                    message != null ? message : error.toString());

                identifier.close();
            });
    }
}
