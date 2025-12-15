package com.topstep.flutter_wearkit.log

import android.content.Context
import android.os.Environment
import androidx.core.content.ContextCompat
import com.github.kilnn.tool.storage.FileUtil
import java.io.File

object AppFiles {
    private const val TAG = "AppFiles"

    fun dirLog(context: Context): File? {
        val externalRoot =
                ContextCompat.getExternalFilesDirs(context, null).firstOrNull() ?: return null
        val logDir = File(externalRoot, "log")
        if (!logDir.exists() && !logDir.mkdirs()) {
            return null
        }
        return logDir
    }

    fun dirPicture(context: Context): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, Environment.DIRECTORY_PICTURES)
                        .firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    fun dirAlbum(context: Context): File? {
        val dir = ContextCompat.getExternalFilesDirs(context, "album").firstOrNull() ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    fun dirAlbums(context: Context, device: String, albumName: String): File? {
        val dir = ContextCompat.getExternalFilesDirs(context, "album").firstOrNull() ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        val deviceDir = File(dir, device)
        if (!deviceDir.exists() && !deviceDir.mkdirs()) {
            return null
        }

        val nameDir = File(deviceDir, albumName)
        if (!nameDir.exists() && !nameDir.mkdirs()) {
            return null
        }
        return nameDir
    }

    fun dirAlbumsTotal(context: Context, device: String): File? {
        val dir = ContextCompat.getExternalFilesDirs(context, "album").firstOrNull() ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        val deviceDir = File(dir, device)
        if (!deviceDir.exists() && !deviceDir.mkdirs()) {
            return null
        }
        return deviceDir
    }

    fun dirReduceAlbums(context: Context, device: String): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "album_reduce").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        val deviceDir = File(dir, device)
        if (!deviceDir.exists() && !deviceDir.mkdirs()) {
            return null
        }
        return deviceDir
    }

    fun stickerDownload(context: Context): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "sticker").firstOrNull() ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    /** 恒玄和绅聚云表盘路径 */
    fun cloudDial(context: Context, name: String): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "cloudDial").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return return File(
                dir,
                if (name.isNullOrEmpty()) {
                    "unknown"
                } else {
                    name
                }
        )
    }

    fun getCloudDial(context: Context): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "cloudDial").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    fun historySticker(context: Context, name: String): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "historySticker").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return return File(
                dir,
                if (name.isNullOrEmpty()) {
                    "unknown"
                } else {
                    name
                }
        )
    }

    fun historyDial(context: Context): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "historySticker").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    /** 恒玄平台自定义表盘路径 */
    fun customDial(context: Context, name: String): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "customDial").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return return File(
                dir,
                if (name.isNullOrEmpty()) {
                    "unknown"
                } else {
                    name
                }
        )
    }

    fun getCustomDial(context: Context): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "customDial").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    /** 因为瑞昱平台的自定义和云表盘是相互覆盖的，所以 两种表盘都根据mac为文件名字保存 */
    fun customOrCloudDial(context: Context, name: String): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "customOrCloudDial").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return File(
                dir,
                if (name.isNullOrEmpty()) {
                    "unknown"
                } else {
                    name
                }
        )
    }

    fun getCustomOrCloudDial(context: Context): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "customOrCloudDial").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    fun sjCustom(context: Context, name: String?): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "sjCustomDial").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return return File(
                dir,
                if (name.isNullOrEmpty()) {
                    "unknown"
                } else {
                    name
                }
        )
    }

    fun getSjCustom(context: Context): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "sjCustomDial").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    fun zipSticker(context: Context, time: String): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, "zipSticker").firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        val timeDir = File(dir, time)
        if (!timeDir.exists() && !timeDir.mkdirs()) {
            return null
        }
        return timeDir
    }

    fun dirDownload(context: Context): File? {
        val dir =
                ContextCompat.getExternalFilesDirs(context, Environment.DIRECTORY_DOWNLOADS)
                        .firstOrNull()
                        ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    fun generateImageFile(context: Context): File? {
        val dir = dirPicture(context) ?: return null
        return File(dir, FileUtil.generateImageFileName())
    }

    fun dirCache(context: Context): File? {
        val dir = ContextCompat.getExternalCacheDirs(context).firstOrNull() ?: return null
        if (!dir.exists() && !dir.mkdirs()) {
            return null
        }
        return dir
    }

    fun generateCacheImageFile(context: Context): File? {
        val dir = dirCache(context) ?: return null
        return File(dir, FileUtil.generateImageFileName())
    }
}
