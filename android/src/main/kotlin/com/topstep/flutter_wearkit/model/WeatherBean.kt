package com.topstep.flutter_wearkit.model

data class WeatherBean(
    val expired_time: Long,//天气数据过期时间，UTC秒时间戳
    val city_name: String?,//城市名，
    val lat: Double,
    val lon: Double,
    val now: Now? = null,
    val daily: List<Day>? = null,
)

data class Now(
    val time: String?,//时间 "2023-07-16T14:24:00+08:00",
    val code: Int,//天气代码
    val text: String?, //天气文字(可能为空或null)，如“多云”
    val temp: String,//温度，默认单位：摄氏度，如"30"，代表30摄氏度
    val windSpeed: String?,//风速
    val pressure: String?,//大气压强(可能为空或null)，如"995"，代表 995hPa
    val vis: String?,//可见度(可能为空或null)，如"10"，代表可见度10米
    val windScale: String?,//风力(可能为空或null)，如"6-7"，代表风力等级为6-7
)

data class Day(
    val time: String?,//日期
    val code: Int,
    val text: String? = null,
    val tempMin: String,//温度，默认单位：摄氏度
    val tempMax: String,//温度，默认单位：摄氏度
)