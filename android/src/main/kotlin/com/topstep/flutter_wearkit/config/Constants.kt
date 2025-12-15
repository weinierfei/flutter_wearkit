package com.topstep.flutter_wearkit.config

import androidx.annotation.IntDef

@IntDef(IntBoolean.FALSE, IntBoolean.TRUE)
@Retention(AnnotationRetention.SOURCE)
annotation class IntBoolean {
    companion object {
        const val FALSE = 0//Int 假
        const val TRUE = 1//Int 真
    }
}

@IntDef(IntSex.MALE, IntSex.FEMALE)
@Retention(AnnotationRetention.SOURCE)
annotation class IntSex {
    companion object {
        const val MALE = 0//男
        const val FEMALE = 1//女
    }
}

@IntDef(MetricImperialUnit.METRIC, MetricImperialUnit.IMPERIAL)
@Retention(AnnotationRetention.SOURCE)
annotation class MetricImperialUnit {
    companion object {
        const val IMPERIAL = 0//英制单位
        const val METRIC = 1//公制单位
    }
}


@IntDef(LengthUnit.METRIC, LengthUnit.IMPERIAL)
@Retention(AnnotationRetention.SOURCE)
annotation class LengthUnit {
    companion object {
        const val METRIC = 0//公制单位
        const val IMPERIAL = 1//英制单位
    }
}
@IntDef(WeightUnit.METRIC, WeightUnit.IMPERIAL)
@Retention(AnnotationRetention.SOURCE)
annotation class WeightUnit {
    companion object {
        const val METRIC = 0//公制单位
        const val IMPERIAL = 1//英制单位
    }
}

@IntDef(TemperatureUnit.CENTIGRADE, TemperatureUnit.FAHRENHEIT)
@Retention(AnnotationRetention.SOURCE)
annotation class TemperatureUnit {
    companion object {
        const val CENTIGRADE = 0//摄氏度
        const val FAHRENHEIT = 1//华氏度
    }
}

@IntDef(TimeFormat.FOLLOW_SYSTEM, TimeFormat.CLOCK_12H, TimeFormat.CLOCK_24H)
@Retention(AnnotationRetention.SOURCE)
annotation class TimeFormat {
    companion object {
        const val FOLLOW_SYSTEM = 0
        const val CLOCK_12H = 1
        const val CLOCK_24H = 2
    }
}

@IntDef(EcgDataType.NORMAL, EcgDataType.TI)
@Retention(AnnotationRetention.SOURCE)
annotation class EcgDataType {
    companion object {
        const val NORMAL = 0 //普通的数据
        const val TI = 1 //ti芯片的数据
    }
}