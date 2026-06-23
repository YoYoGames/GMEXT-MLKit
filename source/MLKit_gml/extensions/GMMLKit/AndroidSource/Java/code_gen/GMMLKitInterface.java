// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;

public interface GMMLKitInterface {
    public double mlkit_translation_create(String source, String target);
    public void mlkit_translation_model_is_available(double translator, GMFunction callback);
    public void mlkit_translation_translate(double translator, String text, GMFunction callback);
    public void mlkit_translation_close(double translator);
    public void mlkit_translation_get_downloaded_list(GMFunction callback);
    public void mlkit_translation_model_delete(String language, GMFunction callback);
    public void mlkit_translation_model_download(String language, GMFunction callback);
}