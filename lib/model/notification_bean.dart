class NotificationConfig {
  // 通知类型常量
  static const int telephony = 0;
  static const int sms = 1;
  static const int qq = 2;
  static const int wechat = 3;
  static const int facebook = 4;
  static const int twitter = 5;
  static const int linkedin = 6;
  static const int instagram = 7;
  static const int whatsapp = 8;
  static const int line = 9;
  static const int facebookMessenger = 10;
  static const int kakao = 11;
  static const int email = 12;
  static const int telegram = 13;
  static const int viber = 14;
  static const int snapchat = 15;
  static const int hike = 16;
  static const int youtube = 17;
  static const int appleMusic = 18;
  static const int zoom = 19;
  static const int tiktok = 20;
  static const int gmail = 21;
  static const int outlook = 22;
  static const int GPay = 23;
  static const int amazon = 24;
  static const int teams = 25;
  static const int zalo = 26;
  static const int dingTalk = 27;
  static const int lark = 28;
  static const int whatsappBusiness = 29;
  static const int iosMail = 30;

}

class NotificationCommonPackages {
  // 常用应用包名常量
  static const String QQ = "com.tencent.mobileqq";
  static const String WECHAT = "com.tencent.mm";
  static const String FACEBOOK = "com.facebook.katana";
  static const String TWITTER = "com.twitter.android";
  static const String LINKEDIN = "com.linkedin.android";
  static const String INSTAGRAM = "com.instagram.android";
  static const String PINTEREST = "com.pinterest";
  static const String WHATS_APP = "com.whatsapp";
  static const String LINE = "jp.naver.line.android";
  static const String FACEBOOK_MESSENGER = "com.facebook.orca";
  static const String KAKAO_TALK = "com.kakao.talk";
  static const String TELEGRAM = "org.telegram.messenger";
  static const String VIBER = "com.viber.voip";
  static const String SNAPCHAT = "com.snapchat.android";
  static const String HIKE = "com.bsb.hike";
  static const String YOUTUBE = "com.google.android.youtube";
  static const String APPLE_MUSIC = "com.apple.android.music";
  static const String ZOOM = "us.zoom.videomeetings";
  static const String WHATS_APP_BUSINESS = "com.whatsapp.w4b";
  static const String TEAMS = "com.microsoft.teams";
  static const String GPAY = "com.cc.grameenphone";
  static const String AMAZON = "com.amazon.mShop.android.shopping";
  static const String ZALO = "com.zing.zalo";
  static const String DING_TALK = "com.alibaba.android.rimet";

  //SMS
  static const String SMS = "com.android.mms";
  static const String SMS_SAMSUNG = "com.samsung.android.messaging";//三星
  static const String SMS_GOOGLE = "com.google.android.apps.messaging";//Google
  static const String SMS_ONE_PLUS = "com.oneplus.mms";//一加
  static const String SMS_OTHERS = "com.android.messaging";//和[SMS_STANDARD]都是Android系统中的通用短信应用包名。不同的手机制造商可能会选择其中一个作为他们设备的短信应用包名。
  static const String MMS_SERVICE = "com.android.mms.service";//彩信
  static const String SMS_HONOR = "com.hihonor.mms"; //荣耀

  //Skype
  static const String SKYPE = "com.skype.raider";
  static const String SKYPE_ROVER = "com.skype.rover";
  static const String SKYPE_INSIDER = "com.skype.insiders";

  //Tiktok
  static const String TIKTOK = "com.ss.android.ugc.trill";
  static const String TIKTOK_MUSICAL_LY = "com.zhiliaoapp.musically";//musical.ly被tiktok收购，合并之后app名称也变为tiktok

  //Lark
  static const String LARK = "com.ss.android.lark";
  static const String LARK_SUITE = "com.larksuite.suite";//飞书国际版

  //Email
  static const String EMAIL = "com.android.email";
  static const String EMAIL_GMAIL = "com.google.android.gm"; //Gmail
  static const String EMAIL_OUTLOOK = "com.microsoft.office.outlook"; //Outlook

  static const String EMAIL_1 = EMAIL_GMAIL;
  static const String EMAIL_2 = "com.tencent.androidqqmail"; //QQ邮箱
  static const String EMAIL_3 = "com.netease.mail"; //邮箱大师(网易)
  static const String EMAIL_4 = "com.netease.mobimail"; //网易邮箱
  static const String EMAIL_5 = "com.yahoo.mobile.client.android.mail"; //Yahoo邮箱
  static const String EMAIL_6 = EMAIL_OUTLOOK;
  static const String EMAIL_7 = "com.my.mail"; //myMail
  static const String EMAIL_8 = "com.mailbox.email"; //邮箱（电子邮件）
  static const String EMAIL_9 = "com.appple.app.email"; //Email（电子邮箱使用）
  static const String EMAIL_10 = "com.tohsoft.mail.email.emailclient"; //电子邮件客户端（电子邮件-快邮）
  static const String EMAIL_11 = "ru.mail.mailapp"; //邮件（Mail.Ru）
  static const String EMAIL_12 = "me.bluemail.mail"; //BlueMail
  static const String EMAIL_13 = "net.daum.android.solmail"; //SOLMail
  static const String EMAIL_14 = "ch.protonmail.android"; //ProtonMail
  static const String EMAIL_15 = "park.outlook.sign.in.clint"; //Email APP（为Outlook与其他邮件客户端电子邮件应用程序）
  static const String EMAIL_16 = "park.yahoo.sign.in.app"; //Email APP（为雅虎与其他邮件客户端电子邮件应用程序）
  static const String EMAIL_17 = "com.google.android.apps.inbox"; //Inbox
  static const String EMAIL_18 = EMAIL; //电子邮件(安卓自动-OPPO)
  static const String EMAIL_19 = "com.google.android.gm.lite"; //Android10 GO版本上Gmail邮箱
  static const String EMAIL_20 = "com.huawei.email"; //Huawei Email

}