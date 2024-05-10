
package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import android.app.Activity;
import android.util.Log;
import java.lang.Exception;
import java.util.HashMap;

import com.google.mlkit.nl.translate.TranslatorOptions;
import com.google.mlkit.nl.translate.Translator;
import com.google.mlkit.nl.translate.Translation;
import com.google.mlkit.nl.translate.TranslateLanguage;
import com.google.mlkit.nl.translate.TranslateRemoteModel;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.mlkit.common.model.DownloadConditions;
import com.google.mlkit.common.model.RemoteModelManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Set;

public class MLKit
{
	private static final int EVENT_OTHER_SOCIAL = 70;	
	public static Activity activity;
	
	private HashMap<String,Translator> Map_Translator;
	
	private double ind = 0;
	
	public MLKit()
	{
		Map_Translator = new HashMap<String,Translator>();
	}
	
	public double mlkit_translation_create(String source,String target)
	{
		TranslatorOptions options = new TranslatorOptions.Builder()
				.setSourceLanguage(source)
				.setTargetLanguage(target)
				.build();
		Translator mTranslator = Translation.getClient(options);
		
		ind ++;
		Map_Translator.put(String.valueOf(ind),mTranslator);
		
		return ind;
	}
	
	public void mlkit_translation_model_is_available(final double ind)
	{
		DownloadConditions conditions = new DownloadConditions.Builder().requireWifi().build();
		
		Translator mTranslator = Map_Translator.get(String.valueOf(ind));
		
		mTranslator.downloadModelIfNeeded(conditions).addOnSuccessListener(new OnSuccessListener<Void>()
		{
			@Override
			public void onSuccess(Void v) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_model_is_available");
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",1.0);
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"translator",ind);
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		}).addOnFailureListener(new OnFailureListener() 
		{
			@Override
			public void onFailure(@NonNull Exception e) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_model_is_available");
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",0.0);
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"translator",ind);
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		});
	}
	
	public void mlkit_translation_translate(final double ind,String text)
	{
		Translator mTranslator = Map_Translator.get(String.valueOf(ind));
		
		mTranslator.translate(text).addOnSuccessListener(new OnSuccessListener<String>()
		{
			@Override
			public void onSuccess(@NonNull String translatedText) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_translate");
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",1.0);
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"translator",ind);
				RunnerJNILib.DsMapAddString(dsMapIndex,"text",translatedText);
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		}).addOnFailureListener(new OnFailureListener() 
		{
			@Override
			public void onFailure(@NonNull Exception e) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_translate");
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",0.0);
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"translator",ind);
				RunnerJNILib.DsMapAddString(dsMapIndex,"error",e.getMessage());
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		});
	}
	
	public void mlkit_translation_close(double ind)
	{
		Translator mTranslator = Map_Translator.get(String.valueOf(ind));
		mTranslator.close();
		
		Map_Translator.remove(String.valueOf(ind));
	}
	
	public void mlkit_translation_get_downloaded_list()
	{
		RemoteModelManager modelManager = RemoteModelManager.getInstance();

		modelManager.getDownloadedModels(TranslateRemoteModel.class).addOnSuccessListener(new OnSuccessListener<Set<TranslateRemoteModel>>() 
		{
			@Override
			public void onSuccess(Set<TranslateRemoteModel> models)
			{
				
				String list = "[";
				for (TranslateRemoteModel s : models) 
				{
					list += "\"";
					list += s.getLanguage();
					list += "\",";
				}
				list += "]";

				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_get_downloaded_list");
				RunnerJNILib.DsMapAddString(dsMapIndex,"list",list);
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",1.0);
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		})
		.addOnFailureListener(new OnFailureListener() 
		{
			@Override
			public void onFailure(@NonNull Exception e) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_get_downloaded_list");
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",0.0);
				RunnerJNILib.DsMapAddString(dsMapIndex,"error",e.getMessage());
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		});
	}


	public void mlkit_translation_model_delete(final String language)
	{
		RemoteModelManager modelManager = RemoteModelManager.getInstance();
		
		TranslateRemoteModel germanModel = new TranslateRemoteModel.Builder(language).build();
		modelManager.deleteDownloadedModel(germanModel).addOnSuccessListener(new OnSuccessListener<Void>() 
		{
			@Override
			public void onSuccess(Void v) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_model_delete");
				RunnerJNILib.DsMapAddString(dsMapIndex,"language",language);
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",1.0);
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		}).addOnFailureListener(new OnFailureListener() 
		{
			@Override
			public void onFailure(@NonNull Exception e) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_model_delete");
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",0.0);
				RunnerJNILib.DsMapAddString(dsMapIndex,"error",e.getMessage());
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		});
	}


	public void mlkit_translation_model_download(final String language)
	{
		RemoteModelManager modelManager = RemoteModelManager.getInstance();
		
		TranslateRemoteModel frenchModel = new TranslateRemoteModel.Builder(language).build();
		DownloadConditions conditions = new DownloadConditions.Builder().requireWifi().build();
		modelManager.download(frenchModel, conditions).addOnSuccessListener(new OnSuccessListener<Void>() 
		{
			@Override
			public void onSuccess(Void v) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_model_download");
				RunnerJNILib.DsMapAddString(dsMapIndex,"language",language);
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",1.0);
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		}).addOnFailureListener(new OnFailureListener()
		{
			@Override
			public void onFailure(@NonNull Exception e) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString(dsMapIndex,"type","mlkit_translation_model_download");
				RunnerJNILib.DsMapAddDouble(dsMapIndex,"success",0.0);
				RunnerJNILib.DsMapAddString(dsMapIndex,"error",e.getMessage());
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
			}
		});
	}
}	
