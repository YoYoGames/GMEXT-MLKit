// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum MLKitLanguageIdentificationStatus
{
    Error((int)-1),
    Undetermined((int)0),
    Identified((int)1);

    private final int value;
    private MLKitLanguageIdentificationStatus(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static MLKitLanguageIdentificationStatus from(int v)
    {
        switch (v)
        {
            case -1:
                return MLKitLanguageIdentificationStatus.Error;
            case 0:
                return MLKitLanguageIdentificationStatus.Undetermined;
            case 1:
                return MLKitLanguageIdentificationStatus.Identified;
            default:
                throw new IllegalArgumentException("Unknown MLKitLanguageIdentificationStatus value: " + v);
        }
    }
}