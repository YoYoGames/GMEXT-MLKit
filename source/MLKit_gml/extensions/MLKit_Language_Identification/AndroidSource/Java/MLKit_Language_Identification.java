
package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import java.lang.Exception;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.nl.languageid.IdentifiedLanguage;
import com.google.mlkit.nl.languageid.LanguageIdentification;
import com.google.mlkit.nl.languageid.LanguageIdentificationOptions;
import com.google.mlkit.nl.languageid.LanguageIdentifier;

public class MLKit_Language_Identification {

	private String undetermined = "und";
	private static final int EVENT_OTHER_SOCIAL = 70;

	public void mlkit_language_identification_identify(String text) {

        LanguageIdentifier languageIdentifier =
                LanguageIdentification.getClient();
        languageIdentifier.identifyLanguage(text)
                .addOnSuccessListener(
                        new OnSuccessListener<String>() {
                            @Override
                            public void onSuccess(@Nullable String languageCode) {
                                if (languageCode.equals(undetermined)) {

                                    int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
									RunnerJNILib.DsMapAddString(dsMapIndex,"type", "mlkit_language_identification_identify");
									RunnerJNILib.DsMapAddString(dsMapIndex,"language_code", undetermined);
									RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",0.0);
									RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
                                } else {

                                    int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
									RunnerJNILib.DsMapAddString(dsMapIndex,"type", "mlkit_language_identification_identify");
									RunnerJNILib.DsMapAddString(dsMapIndex,"language_code", languageCode);
									RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",1.0);
									RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
                                }
                            }
                        })
                .addOnFailureListener(
                        new OnFailureListener() {
                            @Override
                            public void onFailure(@NonNull Exception e) {
                                int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
								RunnerJNILib.DsMapAddString(dsMapIndex,"type", "mlkit_language_identification_identify");
								RunnerJNILib.DsMapAddString(dsMapIndex,"error", e.toString());
								RunnerJNILib.DsMapAddDouble(dsMapIndex,"success", -1.0);
								RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
                            }
                        });
    }

}