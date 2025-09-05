// ExampleConfiguration.java
// FlutterExample Copyright © 2022-2025; Electric Bolt Limited.

package nz.co.electricbolt.appfigurateflutter_example;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import nz.co.electricbolt.appfiguratelibrary.Configuration;
import nz.co.electricbolt.appfiguratelibrary.annotations.ActionMethod;
import nz.co.electricbolt.appfiguratelibrary.annotations.BooleanProperty;
import nz.co.electricbolt.appfiguratelibrary.annotations.DoublePropertyEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.DoublePropertyList;
import nz.co.electricbolt.appfiguratelibrary.annotations.DoublePropertyListEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.DoublePropertySlider;
import nz.co.electricbolt.appfiguratelibrary.annotations.EncryptedStringPropertyListEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.FloatPropertyEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.FloatPropertyList;
import nz.co.electricbolt.appfiguratelibrary.annotations.FloatPropertyListEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.FloatPropertySlider;
import nz.co.electricbolt.appfiguratelibrary.annotations.IconSlider;
import nz.co.electricbolt.appfiguratelibrary.annotations.IntPropertyEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.IntPropertyList;
import nz.co.electricbolt.appfiguratelibrary.annotations.IntPropertyListEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.IntPropertySlider;
import nz.co.electricbolt.appfiguratelibrary.annotations.RemoteBooleanProperty;
import nz.co.electricbolt.appfiguratelibrary.annotations.RemoteDoublePropertyEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.RemoteIntPropertyEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.RemoteStringPropertyEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.StringPropertyEdit;
import nz.co.electricbolt.appfiguratelibrary.annotations.StringPropertyList;
import nz.co.electricbolt.appfiguratelibrary.annotations.StringPropertyListEdit;

public class ExampleConfiguration extends Configuration {

    public static ExampleConfiguration CONFIGURATION() {
        return (ExampleConfiguration) Configuration.sharedConfiguration();
    }

    // region boolean

    @BooleanProperty(description = "boolean - Boolean true or false")
    public boolean bool;

    // endregion  boolean

    // region String

    @StringPropertyEdit(description = "String - textfield", restart = true)
    String string_Textfield;

    @StringPropertyEdit(description = "String - textfield with regex", regularExpression = "b[aeiou]t")
    public String getString_RegexTextfield() {
        return _string_RegexTextfield;
    }

    public void setString_RegexTextfield(String value) {
        _string_RegexTextfield = value;
    }

    private String _string_RegexTextfield;

    @StringPropertyList(description = "String - fixed list", keys = {
            "{PVT,DEV}Small",
            "Medium",
            "{TEST}Large"
    }, values = {
            "sm",
            "md",
            "lg"
    })
    String string_List;

    @StringPropertyListEdit(description = "String - textfield, customizable list", keys = {
            "{DEV}Red",
            "Green",
            "{pvt,TEST}Blue"
    }, values = {
            "r",
            "g",
            "b"
    })
    String string_Textfield_List;

    @StringPropertyListEdit(description = "String - textfield with regex, customizable list",
            regularExpression = "https://[\\w\\.-]+\\.electricbolt.co.nz/.*", keys = {
            "{DEV}Dev",
            "{TEST}Test",
            "{PVT}Prod"
    }, values = {
            "https://dev.electricbolt.co.nz/list",
            "https://test.electricbolt.co.nz/list",
            "https://m.electricbolt.co.nz/list"
    })
    String string_RegexTextfield_List;

    // endregion String

    // region Encrypted String

    @EncryptedStringPropertyListEdit(description = "encrypted String - textfield, customizable list",
            encrypted = BuildConfig.ENCRYPTED)
    String encrypted_string_Textfield_List;

    static Map<String, String> _encrypted_string_Textfield_ListValues = new HashMap<>();

    static {
        _encrypted_string_Textfield_ListValues.put("{DEV}Red", BuildConfig.ENCRYPTED ? "3/iZZ1Gv8EniGIkIoUzLdJI8SN8tGjus/jGanA6kRM+afnCJYI4E/6Nc1CWK7eIAJBuZRceU6rtlY/OPTSubV4kLQkf/I4gN4pdrC0T8wZSI6uq7xSWk3nfGG6Ujh5sopOpvseCfg+TaTCfYgEgBwlCuxKZICMNH36BZT41v14foSG8AiGjXVcyQ1eYhY9SxQSd8ZsrQhUyyVcInsuJP3GK20yOg2yQjsbOHD3OfkI+adP5M7Y3B7oC/1sPz+CK2ZNhnOMSTeIl3NpfH6YhSkg2Oh5GTZI2cNAGYxPVTgF6/oCCmky8pgZwQFkh7KKqlKKWEB8Mec5emzr2I3IFF8nNQcsX0ck2sGNClqWXY3ysB" : "r");
        _encrypted_string_Textfield_ListValues.put("{PVT}Green", BuildConfig.ENCRYPTED ? "PkQfHwaWmK94u9eB9mCfWmOk/vOIOacKivt1lptgJbUzUl2e8pmRnSVLkCeYxoSjPgKEx94t6e/BRhtgMbZyXoo2usUH5jdxaA8HkoUtR4VuMHuZ4Gla+kyuNg1Ki6LC+xAD++dESITzX4EqCCCfVV/qv5u5c9NJYrc7TwNN8bXtVJ6+8hEQeWXdk/05p0wCDjx8hIl+wfmjbKOYwl35mQMW/4EM7SEYFqExxMsR/dcHJG4X0Mw03hEfdqL9nk0anMEyx8ez03WmR8TiZg4UqpbARr6i8IUYx6pMr2ZJjQUzllvTxGpT84VetpN1tvp/Ys+ygtOODZuSp3MjpG0M/tiyGe8g7gNIdauWxN1afdgB" : "g");
        _encrypted_string_Textfield_ListValues.put("{TEST}Blue", BuildConfig.ENCRYPTED ? "jaIxDwexYEFUlmoG8QsdKYbj/g2zZWL0q5gmeWGCuLOwXvUHdB0CU7i4v/55LEi3UuN7L9Yj4zjWX//WZB0HFn5+9NZ8IG9xoc+uE+vDMbxAKaqjA5IfJM38eVl0DK/hp0le3qOG11sd+GXoSXSDiwKWGoihqYZ6GUzgDTx8f2OlhqG/SUlm/jADLUNJjK8czZ8fY+Fx75cj7OTlOl+nikFoE5BkR3exOYkeCmAY2KgCYyJQn2w3yaBS0tGafUjAIHIHITodrjG+IbjZLhZyG2/jxkMjLNDs0GCWH6vh+mQ9h6Iwzq3UIZnK9zUn2D4cZV5I2StjPpPdAkGrsdIv0L/bQJZjAnidQIWOC5iB7poB" : "b");
    }

    public Map<String, String> encrypted_string_Textfield_ListValues() {
        return _encrypted_string_Textfield_ListValues;
    }

    @EncryptedStringPropertyListEdit(description = "encrypted String - textfield with regex, customizable list",
            regularExpression = "https://[\\w\\.-]+\\.appfigurate.io/.*", encrypted = BuildConfig.ENCRYPTED)
    String encrypted_string_RegexTextfield_List;

    static Map<String, String> _encrypted_string_RegexTextfield_ListValues = new HashMap<>();

    static {
        _encrypted_string_RegexTextfield_ListValues.put("{DEV}Dev", BuildConfig.ENCRYPTED ? "jm9SM4MEYa4FRbTrK23n6QWpBl0MfLolPPUrnaUcMcCzmJbzBT0MumGIEFFthMFbx5ZZta8mCIKYwBR2Cu/2b52rFUr2N8xCuWiWURS0erO6sxdY3bJSzRJPo70aGYzMLydVrxUtHv1BjeLTYaG/25hF5JYWf8/TOA4lBRgMsttwbiO+0D6u1qGh4pewpTD5lI8jK39sY3DfSco7+61chGakI7n44y/+toqxWl8rEa5+I9eL0vDASfe7V2KvBhQGV8FLZDkVo0a0fqcCeq5AXU1bl0bMXIB2anN1PdihbPjOLZgpllIzuY+Hy8gFfpoCGQRAiiPSI2YDxT+pg2fKUBMQ9OqFAC5fi+7DqfRhy6SRXjfemq5cDglwMGnpRI4JAQ==" : "https://dev.appfigurate.io/list");
        _encrypted_string_RegexTextfield_ListValues.put("{TEST}Test", BuildConfig.ENCRYPTED ? "4H4M2YQ2XH+bm7FYVm1sQuN+DaUQdvJecWLKYo3peUYwNJsw+bE/ANFbtfD6xDWCnDW8Bs62tqYDtyg6YhucnTjx82c+axxKG/eDpEd3nPdiWubrw3UwuWa8xKIH8RFVQyRDpWrCbSDG/rREiRdUUs4Lwer7uJfOa92u9iN56T5rgH7/IXfo2N///FxmN/6Tr2vVXNVc+m3snBE8B05+4WUKuDLkjGcmHfzlnRiQVyDDyNKDNr1vDoZduu5Fb5CwPfCrxNIJY4r0XFyPIv+pjAG/Z8Tl2dud6SjCzKirb1Nc0ZeQsCKyhSXDN3PC82qMbviAlkCOvkZ2mca4mRcW1VqeR63Ujp37lCAZKExPdqSlElI4Z0J7/dHuEyMFNP1/xngi3iuOxO6L7Qy9i/RTnQE=" : "https://test.appfigurate.io/list");
        _encrypted_string_RegexTextfield_ListValues.put("{PVT}Prod", BuildConfig.ENCRYPTED ? "IE7X1bkOQGAqCTtLk011hG0Kmj5l0RkSviSO6IfItnIlSEL66ZH1cO4vmN8FtjkWhD+zvcDzHkcsVSsqPrkmYJl29I2otn2dXa9tNIZMW3it1kyoyxnZLwzIJhPGORTMxeLN9h+U36lydUA4fASALFFP+uC+bVHVdvIVUMoGBDdoVwZAXyss4C+rgLTafkok4Hcz/a6rXC5SsluX8/LTnomluqfi8bgrSS2xJKKpHsQQllQmsshublBJ57bKn3EeKmo6DxwBuwBVA2nAdyoi1bLUYN+XN1sjzLaAuYyZeDJGs9qiuj78HCyN4ZrcVe3x00AbNAlSISrZJrw2oMt3exSGFGKAenClYqwoVygDPIPI3vNFCRFcp29N7T4S78K5AQ==" : "https://m.appfigurate.io/list");
    }

    public Map<String, String> encrypted_string_RegexTextfield_ListValues() {
        return _encrypted_string_RegexTextfield_ListValues;
    }

    // endregion Encrypted String

    // region int

    @IntPropertySlider(description = "int - slider", minValue = 0, maxValue = 1000,
            sliderIcon = IconSlider.IconSliderNumeric, restart = true)
    int integer_Slider;

    @IntPropertyEdit(description = "int - textfield", minValue = 10, maxValue = 20)
    int integer_Textfield;

    @IntPropertyEdit(description = "int - textfield with regex", minValue = 1, maxValue = 999,
            regularExpression = "^([1-9]|[1-9][0-9]|[1-9][0-9][0-9])$")
    int integer_RegexTextfield;

    @IntPropertyList(description = "int - fixed list", keys = {
            "None",
            "{DEV}Low",
            "{PVT}Zero",
            "High",
            "{TEST}Urgent"
    }, values = {
            -100,
            -50,
            0,
            50,
            100
    })
    int integer_List;

    @IntPropertyListEdit(description = "int - textfield, customizable list", minValue = 0, maxValue = 100, keys = {
            "Failed",
            "Pass",
            "Excellence"
    }, values = {
            0,
            80,
            90
    })
    int integer_Textfield_List;

    @IntPropertyListEdit(description = "int - textfield with regex, customizable list", minValue = 0, maxValue = 365,
            regularExpression = "^(0?[0-9]?[0-9]|[1-2][0-9][0-9]|3[0-5][0-9]|36[0-5])$", keys = {
            "0 days",
            "1 month",
            "1 Year"
    }, values = {
            0,
            30,
            365
    })
    int integer_RegexTextfield_List;

    // endregion int

    // region float

    @FloatPropertySlider(description = "float - slider", minValue = 0.0f, maxValue = 1000.0f,
            sliderIcon = IconSlider.IconSliderVolume)
    float float_Slider;

    @FloatPropertyEdit(description = "float - textfield", minValue = 10.0f, maxValue = 20.0f, restart = true)
    float float_Textfield;

    @FloatPropertyEdit(description = "float - textfield with regex", minValue = 5.0f, maxValue = 250.0f,
            regularExpression = "^(?:[1-9]\\d*|0)?(?:\\.\\d+)?$")
    float float_RegexTextfield;

    @FloatPropertyList(description = "float - fixed list", keys = {
            "None",
            "Low",
            "Zero",
            "High",
            "Urgent"
    }, values = {
            -100.0f,
            -50.0f,
            0.0f,
            50.0f,
            100.0f
    })
    float float_List;

    @FloatPropertyListEdit(description = "float - textfield, customizable list", minValue = 0.0f, maxValue = 100.0f,
            keys = {
                    "Failed",
                    "Pass",
                    "Excellence"
            }, values = {
            0.0f,
            80.0f,
            90.0f
    })
    float float_Textfield_List;

    @FloatPropertyListEdit(description = "Float - textfield with regex, customizable list", minValue = 0.0f,
            maxValue = 366.0f, regularExpression = "^(0?[0-9]?[0-9]|[1-2][0-9][0-9]|3[0-5][0-9]|36[0-5])?(?:\\.\\d+)?$",
            keys = {
                    "0 days",
                    "1 month",
                    "1 Year"
            }, values = {
            0.0f,
            30.0f,
            365.0f
    })
    float float_RegexTextfield_List;

    // endregion float

    // region double

    @DoublePropertySlider(description = "double - slider", minValue = 0.0d, maxValue = 1000.0d,
            sliderIcon = IconSlider.IconSliderBrightness)
    double double_Slider;

    @DoublePropertyEdit(description = "double - textfield", minValue = 10.0d, maxValue = 20.0d)
    double double_Textfield;

    @DoublePropertyEdit(description = "double - textfield with regex", minValue = 5.0d, maxValue = 250.0d,
            regularExpression = "^(?:[1-9]\\d*|0)?(?:\\.\\d+)?$")
    double double_RegexTextfield;

    @DoublePropertyList(description = "double - fixed list", keys = {
            "None",
            "Low",
            "Zero",
            "High",
            "Urgent"
    }, values = {
            -100.0d,
            -50.0d,
            0.0d,
            50.0d,
            100.0d
    }, restart = true)
    double double_List;

    @DoublePropertyListEdit(description = "double - textfield, customizable list", minValue = 0.0d, maxValue = 100.0d,
            keys = {
                    "Failed",
                    "Passed",
                    "Excellence"
            }, values = {
            0.0d,
            80.0d,
            90.0d
    })
    double double_Textfield_List;

    @DoublePropertyListEdit(description = "double - textfield with regex, customizable list", minValue = 0.0d,
            maxValue = 366.0d, regularExpression = "^(0?[0-9]?[0-9]|[1-2][0-9][0-9]|3[0-5][0-9]|36[0-5])?(?:\\.\\d+)?$",
            keys = {
                    "0 days",
                    "1 month",
                    "1 Year"
            }, values = {
            0.0d,
            30.0d,
            365.0d
    })
    double double_RegexTextfield_List;

    // endregion double

    // region Action Methods

    @ActionMethod(description = "Set all integer properties to random values", restart = true)
    public void randomIntegers() {
        Random random = new Random();
        integer_Slider = random.nextInt(1001);
        integer_Textfield = random.nextInt(11) + 10;
        integer_RegexTextfield = random.nextInt(999) + 1;
        switch (random.nextInt(5)) {
            case 0:
                integer_List = -100;
                break;
            case 1:
                integer_List = -50;
                break;
            case 2:
                integer_List = 0;
                break;
            case 3:
                integer_List = 50;
                break;
            default:
                integer_List = 100;
        }
        switch (random.nextInt(3)) {
            case 0:
                integer_Textfield_List = 0;
                break;
            case 1:
                integer_Textfield_List = 80;
                break;
            default:
                integer_Textfield_List = 90;
        }
        integer_RegexTextfield_List = random.nextInt(366);
    }

    @ActionMethod(description = "Reset integer properties to defaults", restart = true)
    public void resetIntegers() {
        integer_Slider = 500;
        integer_Textfield = 10;
        integer_RegexTextfield = 500;
        integer_List = 0;
        integer_Textfield_List = 80;
        integer_RegexTextfield_List = 30;
    }

    // endregion Action Methods

    @Override
    public boolean allowInvalidSignatures() {
        return BuildConfig.DEBUG;
    }

    @NonNull
    @Override
    public String publicKey() {
        // 41 36 87 71 0D 05
        return "-----BEGIN PUBLIC KEY-----\n" +
                "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4TZnKfGeXttN7Rr3eiAZ\n" +
                "PMEPsZvbo7lgIpMh6OjgBsoqkJJP0yXXLtpqsBCv8vm7RYqCn5+yfkiCQiXvkJBz\n" +
                "FSKmLF9EPR9l1H+32Id82dDuseD70D66puPUHjciEgmU18DpW2NVvTAykMwTEsiR\n" +
                "0h/ExBEhUe75qtwlVno8cMFbEfVtiGbKECvWIr122ED71T0Jt2Bcxqx1a7c1hPIV\n" +
                "RwLxIfWfE0+2rB9nJVPBgsTVPywibDvjio82FousyMDmvkAbMq5iyuyvJ0+5bATz\n" +
                "o12GEt5lSiQlCMzfmkWYBROMDCh27qGFVVo1XAUCVsMfsW9n4iQcoLAdUp/LI3B3\n" +
                "ywIDAQAB\n" +
                "-----END PUBLIC KEY-----\n";
    }

    @Override
    public String[] environmentTags() {
        return new String[]{"Dev", "Test", "PVT"};
    }

    @Override
    public void reset() {
        this.bool = true;
        this.string_Textfield = "tuesday";
        this._string_RegexTextfield = "bot";
        this.string_List = "sm";
        this.string_Textfield_List = "g";
        this.string_RegexTextfield_List = "https://m.electricbolt.co.nz/list";
        this.encrypted_string_Textfield_List = "g";
        this.encrypted_string_RegexTextfield_List = "https://m.appfigurate.io/list";
        this.integer_Slider = 500;
        this.integer_Textfield = 10;
        this.integer_RegexTextfield = 500;
        this.integer_List = 0;
        this.integer_Textfield_List = 80;
        this.integer_RegexTextfield_List = 30;
        this.float_Slider = 950.0f;
        this.float_Textfield = 12.0f;
        this.float_RegexTextfield = 5.95f;
        this.float_List = -50.0f;
        this.float_Textfield_List = 80.0f;
        this.float_RegexTextfield_List = 365.0f;
        this.double_Slider = 950.0;
        this.double_Textfield = 12.0;
        this.double_RegexTextfield = 5.95;
        this.double_List = -50.0;
        this.double_Textfield_List = 80.0;
        this.double_RegexTextfield_List = 365.0;
    }

}
