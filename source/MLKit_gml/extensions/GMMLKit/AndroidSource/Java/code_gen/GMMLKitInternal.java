// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};

import java.nio.ByteBuffer;
import java.util.*;
import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;

public abstract class GMMLKitInternal extends RunnerSocial implements GMMLKitInterface {

    private final GMExtWire.DispatchQueue __dispatch_queue = new GMExtWire.DispatchQueue();
    public double __EXT_NATIVE__GMMLKit_invocation_handler(ByteBuffer __ret_buffer, double __ret_buffer_length)
    {
        return __dispatch_queue.fetch(__ret_buffer);
    }

    public double __EXT_NATIVE__mlkit_translation_create(String source, String target)
    {
        double __result = mlkit_translation_create(source, target);
        return (double)__result;
    }

    public double __EXT_NATIVE__mlkit_translation_model_is_available(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: translator, type: Float64
        double translator = GMExtWire.readF64(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mlkit_translation_model_is_available(translator, callback);
        return 0;
    }

    public double __EXT_NATIVE__mlkit_translation_translate(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: translator, type: Float64
        double translator = GMExtWire.readF64(__arg_buffer);

        // field: text, type: String
        String text = GMExtWire.readString(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mlkit_translation_translate(translator, text, callback);
        return 0;
    }

    public double __EXT_NATIVE__mlkit_translation_close(double translator)
    {
        mlkit_translation_close((double)translator);
        return 0;
    }

    public double __EXT_NATIVE__mlkit_translation_get_downloaded_list(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mlkit_translation_get_downloaded_list(callback);
        return 0;
    }

    public double __EXT_NATIVE__mlkit_translation_model_delete(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: language, type: String
        String language = GMExtWire.readString(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mlkit_translation_model_delete(language, callback);
        return 0;
    }

    public double __EXT_NATIVE__mlkit_translation_model_download(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: language, type: String
        String language = GMExtWire.readString(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mlkit_translation_model_download(language, callback);
        return 0;
    }

}