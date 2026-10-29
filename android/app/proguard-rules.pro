# Abaikan semua peringatan dan paksa R8 untuk menjaga TensorFlow Lite beserta dependensinya
-keep class org.tensorflow.lite.** { *; }
-dontwarn org.tensorflow.lite.**

# Aturan khusus untuk modul GPU yang memicu error kemarin
-keep class org.tensorflow.lite.gpu.** { *; }
-dontwarn org.tensorflow.lite.gpu.**

# Tambahan pelindung umum untuk library eksternal agar R8 tidak tebang pilih
-dontoptimize
-dontobfuscate