# Flutter ProGuard / R8 Rules for Revolt EV Platform
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Serialization and Freezed Models
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod
-dontwarn javax.annotation.**

# SQLite and Drift Database
-keep class com.tekartik.sqflite.** { *; }
-keep class org.sqlite.** { *; }

# Bluetooth Low Energy SDK
-keep class com.revolt.** { *; }
-keep class com.boskokg.flutter_blue_plus.** { *; }
