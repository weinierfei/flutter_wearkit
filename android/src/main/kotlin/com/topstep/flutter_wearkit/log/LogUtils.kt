package com.topstep.flutter_wearkit.log

import android.content.ClipData
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.annotation.IntDef
import androidx.annotation.IntRange
import androidx.annotation.RequiresApi
import java.lang.reflect.ParameterizedType
import java.text.SimpleDateFormat
import java.util.*

/**
 * <pre>
 * ```
 *     author: Blankj
 *     blog  : http://blankj.com
 *     time  : 2016/09/21
 *     desc  : utils about log
 * ```
 * </pre>
 */
object LogUtils {

    const val V = Log.VERBOSE
    const val D = Log.DEBUG
    const val I = Log.INFO
    const val W = Log.WARN
    const val E = Log.ERROR
    const val A = Log.ASSERT

    @IntDef(V, D, I, W, E, A) @Retention(AnnotationRetention.SOURCE) annotation class TYPE

    private val T = charArrayOf('V', 'D', 'I', 'W', 'E', 'A')

    private val LINE_SEP = System.getProperty("line.separator")
    private const val TOP_CORNER = "┌"
    private const val MIDDLE_CORNER = "├"
    private const val LEFT_BORDER = "│ "
    private const val BOTTOM_CORNER = "└"
    private const val SIDE_DIVIDER = "────────────────────────────────────────────────────────"
    private const val MIDDLE_DIVIDER = "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"
    private val TOP_BORDER = TOP_CORNER + SIDE_DIVIDER + SIDE_DIVIDER
    private val MIDDLE_BORDER = MIDDLE_CORNER + MIDDLE_DIVIDER + MIDDLE_DIVIDER
    private val BOTTOM_BORDER = BOTTOM_CORNER + SIDE_DIVIDER + SIDE_DIVIDER
    private const val MAX_LEN = 1100 // fit for Chinese character
    private const val NOTHING = "log nothing"
    private const val NULL = "null"
    private const val ARGS = "args"
    private const val PLACEHOLDER = " "
    private val CONFIG = Config()

    private var simpleDateFormat: SimpleDateFormat? = null

    fun getConfig(): Config {
        return CONFIG
    }

    @JvmStatic
    fun v(vararg contents: Any?) {
        log(V, CONFIG.globalTag, *contents)
    }

    @JvmStatic
    fun vTag(tag: String, vararg contents: Any?) {
        log(V, tag, *contents)
    }

    @JvmStatic
    fun d(vararg contents: Any?) {
        log(D, CONFIG.globalTag, *contents)
    }

    @JvmStatic
    fun dTag(tag: String, vararg contents: Any?) {
        log(D, tag, *contents)
    }

    @JvmStatic
    fun i(vararg contents: Any?) {
        log(I, CONFIG.globalTag, *contents)
    }

    @JvmStatic
    fun iTag(tag: String, vararg contents: Any?) {
        log(I, tag, *contents)
    }

    @JvmStatic
    fun w(vararg contents: Any?) {
        log(W, CONFIG.globalTag, *contents)
    }

    @JvmStatic
    fun wTag(tag: String, vararg contents: Any?) {
        log(W, tag, *contents)
    }

    @JvmStatic
    fun e(vararg contents: Any?) {
        log(E, CONFIG.globalTag, *contents)
    }

    @JvmStatic
    fun eTag(tag: String, vararg contents: Any?) {
        log(E, tag, *contents)
    }

    @JvmStatic
    fun a(vararg contents: Any?) {
        log(A, CONFIG.globalTag, *contents)
    }

    @JvmStatic
    fun aTag(tag: String, vararg contents: Any?) {
        log(A, tag, *contents)
    }

    @JvmStatic
    fun log(type: Int, tag: String, vararg contents: Any?) {
        if (!CONFIG.isLogSwitch) return
        val typeLow = type and 0x0f
        val typeHigh = type and 0xf0
        if (typeLow < CONFIG.mConsoleFilter) return
        val tagHead = processTagAndHead(tag)
        val body = processBody(typeHigh, *contents)
        if (CONFIG.isLog2ConsoleSwitch && typeLow >= CONFIG.mConsoleFilter) {
            print2Console(typeLow, tagHead.tag, tagHead.consoleHead, body)
        }
    }

    private fun processTagAndHead(tag: String): TagHead {
        return TagHead(CONFIG.globalTag, null, ": ")
    }

    private fun processBody(type: Int, vararg contents: Any?): String {
        var body = NULL
        if (contents != null) {
            if (contents.size == 1) {
                body = formatObject(type, contents[0])
            } else {
                val sb = StringBuilder()
                for (i in contents.indices) {
                    val content = contents[i]
                    sb.append(ARGS)
                            .append("[")
                            .append(i)
                            .append("]")
                            .append(" = ")
                            .append(formatObject(content))
                            .append(LINE_SEP)
                }
                body = sb.toString()
            }
        }
        return if (body.isEmpty()) NOTHING else body
    }

    private fun formatObject(type: Int, obj: Any?): String {
        if (obj == null) return NULL
        return formatObject(obj)
    }

    private fun formatObject(obj: Any?): String {
        if (obj == null) return NULL
        return LogFormatter.object2String(obj)
    }

    private fun print2Console(type: Int, tag: String, head: Array<String>?, msg: String) {
        if (CONFIG.isSingleTagSwitch) {
            printSingleTagMsg(type, tag, processSingleTagMsg(type, tag, head, msg))
        } else {
            printBorder(type, tag, true)
            printHead(type, tag, head)
            printMsg(type, tag, msg)
            printBorder(type, tag, false)
        }
    }

    private fun printBorder(type: Int, tag: String, isTop: Boolean) {
        if (CONFIG.isLogBorderSwitch) {
            print2Console(type, tag, if (isTop) TOP_BORDER else BOTTOM_BORDER)
        }
    }

    private fun printHead(type: Int, tag: String, head: Array<String>?) {
        if (head != null) {
            for (aHead in head) {
                print2Console(
                        type,
                        tag,
                        if (CONFIG.isLogBorderSwitch) LEFT_BORDER + aHead else aHead
                )
            }
            if (CONFIG.isLogBorderSwitch) print2Console(type, tag, MIDDLE_BORDER)
        }
    }

    private fun printMsg(type: Int, tag: String, msg: String) {
        val len = msg.length
        val countOfSub = len / MAX_LEN
        if (countOfSub > 0) {
            var index = 0
            for (i in 0 until countOfSub) {
                printSubMsg(type, tag, msg.substring(index, index + MAX_LEN))
                index += MAX_LEN
            }
            if (index != len) {
                printSubMsg(type, tag, msg.substring(index, len))
            }
        } else {
            printSubMsg(type, tag, msg)
        }
    }

    private fun printSubMsg(type: Int, tag: String, msg: String) {
        if (!CONFIG.isLogBorderSwitch) {
            print2Console(type, tag, msg)
            return
        }
        val lines = msg.split(LINE_SEP.toRegex()).toTypedArray()
        for (line in lines) {
            print2Console(type, tag, LEFT_BORDER + line)
        }
    }

    private fun processSingleTagMsg(
            type: Int,
            tag: String,
            head: Array<String>?,
            msg: String
    ): String {
        val sb = StringBuilder()
        if (CONFIG.isLogBorderSwitch) {
            sb.append(PLACEHOLDER).append(LINE_SEP)
            sb.append(TOP_BORDER).append(LINE_SEP)
            if (head != null) {
                for (aHead in head) {
                    sb.append(LEFT_BORDER).append(aHead).append(LINE_SEP)
                }
                sb.append(MIDDLE_BORDER).append(LINE_SEP)
            }
            for (line in msg.split(LINE_SEP.toRegex()).toTypedArray()) {
                sb.append(LEFT_BORDER).append(line).append(LINE_SEP)
            }
            sb.append(BOTTOM_BORDER)
        } else {
            if (head != null) {
                sb.append(PLACEHOLDER).append(LINE_SEP)
                for (aHead in head) {
                    sb.append(aHead).append(LINE_SEP)
                }
            }
            sb.append(msg)
        }
        return sb.toString()
    }

    private fun printSingleTagMsg(type: Int, tag: String, msg: String) {
        val len = msg.length
        val countOfSub =
                if (CONFIG.isLogBorderSwitch) (len - BOTTOM_BORDER.length) / MAX_LEN
                else len / MAX_LEN
        if (countOfSub > 0) {
            if (CONFIG.isLogBorderSwitch) {
                print2Console(type, tag, msg.substring(0, MAX_LEN) + LINE_SEP + BOTTOM_BORDER)
                var index = MAX_LEN
                for (i in 1 until countOfSub) {
                    print2Console(
                            type,
                            tag,
                            PLACEHOLDER +
                                    LINE_SEP +
                                    TOP_BORDER +
                                    LINE_SEP +
                                    LEFT_BORDER +
                                    msg.substring(index, index + MAX_LEN) +
                                    LINE_SEP +
                                    BOTTOM_BORDER
                    )
                    index += MAX_LEN
                }
                if (index != len - BOTTOM_BORDER.length) {
                    print2Console(
                            type,
                            tag,
                            PLACEHOLDER +
                                    LINE_SEP +
                                    TOP_BORDER +
                                    LINE_SEP +
                                    LEFT_BORDER +
                                    msg.substring(index, len)
                    )
                }
            } else {
                print2Console(type, tag, msg.substring(0, MAX_LEN))
                var index = MAX_LEN
                for (i in 1 until countOfSub) {
                    print2Console(
                            type,
                            tag,
                            PLACEHOLDER + LINE_SEP + msg.substring(index, index + MAX_LEN)
                    )
                    index += MAX_LEN
                }
                if (index != len) {
                    print2Console(type, tag, PLACEHOLDER + LINE_SEP + msg.substring(index, len))
                }
            }
        } else {
            print2Console(type, tag, msg)
        }
    }

    private fun print2Console(type: Int, tag: String, msg: String) {
        Log.println(type, tag, msg)
    }

    class Config {
        var isLogSwitch = true // The switch of log.
        var isLog2ConsoleSwitch = true // The logcat's switch of log.
        var globalTag = "" // The global tag of log.
        var mTagIsSpace = true // The global tag is space.
        var isLogHeadSwitch = true // The head's switch of log.
        var isLogBorderSwitch = true // The border's switch of log.
        var isSingleTagSwitch = true // The single tag of log.
        var mConsoleFilter = V // The console's filter of log.
        var stackDeep = 1 // The stack's deep of log.
        var stackOffset = 0 // The stack's offset of log.

        fun setLogSwitch(logSwitch: Boolean): Config {
            isLogSwitch = logSwitch
            return this
        }

        fun setConsoleSwitch(consoleSwitch: Boolean): Config {
            isLog2ConsoleSwitch = consoleSwitch
            return this
        }

        fun setGlobalTag(tag: String): Config {
            globalTag = tag
            mTagIsSpace = false
            return this
        }

        fun setLogHeadSwitch(logHeadSwitch: Boolean): Config {
            isLogHeadSwitch = logHeadSwitch
            return this
        }

        fun setBorderSwitch(borderSwitch: Boolean): Config {
            isLogBorderSwitch = borderSwitch
            return this
        }

        fun setSingleTagSwitch(singleTagSwitch: Boolean): Config {
            isSingleTagSwitch = singleTagSwitch
            return this
        }

        fun setConsoleFilter(@TYPE consoleFilter: Int): Config {
            mConsoleFilter = consoleFilter
            return this
        }

        fun setStackDeep(@IntRange(from = 1) stackDeep: Int): Config {
            this.stackDeep = stackDeep
            return this
        }

        fun setStackOffset(@IntRange(from = 0) stackOffset: Int): Config {
            this.stackOffset = stackOffset
            return this
        }

        val consoleFilter: Char
            get() = T[mConsoleFilter - V]

        override fun toString(): String {
            return "logSwitch: " +
                    isLogSwitch +
                    LINE_SEP +
                    "consoleSwitch: " +
                    isLog2ConsoleSwitch +
                    LINE_SEP +
                    "tag: " +
                    (if (globalTag.isEmpty()) "null" else globalTag) +
                    LINE_SEP +
                    "headSwitch: " +
                    isLogHeadSwitch +
                    LINE_SEP +
                    "borderSwitch: " +
                    isLogBorderSwitch +
                    LINE_SEP +
                    "singleTagSwitch: " +
                    isSingleTagSwitch +
                    LINE_SEP +
                    "consoleFilter: " +
                    consoleFilter +
                    LINE_SEP +
                    "stackDeep: " +
                    stackDeep +
                    LINE_SEP +
                    "stackOffset: " +
                    stackOffset
        }
    }

    private class TagHead
    internal constructor(var tag: String, var consoleHead: Array<String>?, var fileHead: String)

    private object LogFormatter {

        fun object2String(obj: Any?): String {
            return object2String(obj, -1)
        }

        fun object2String(obj: Any?, type: Int): String {
            if (obj == null) return NULL
            if (obj.javaClass.isArray) return array2String(obj)
            if (obj is Bundle) return bundle2String(obj)
            if (obj is Intent) return intent2String(obj)
            return obj.toString()
        }

        private fun bundle2String(bundle: Bundle): String {
            val iterator = bundle.keySet().iterator()
            if (!iterator.hasNext()) {
                return "Bundle {}"
            }
            val sb = StringBuilder(128)
            sb.append("Bundle { ")
            while (true) {
                val key = iterator.next()
                val value = bundle.get(key)
                sb.append(key).append('=')
                if (value is Bundle) {
                    sb.append(if (value === bundle) "(this Bundle)" else bundle2String(value))
                } else {
                    sb.append(formatObject(value))
                }
                if (!iterator.hasNext()) return sb.append(" }").toString()
                sb.append(',').append(' ')
            }
        }

        private fun intent2String(intent: Intent): String {
            val sb = StringBuilder(128)
            sb.append("Intent { ")
            var first = true
            val mAction = intent.action
            if (mAction != null) {
                sb.append("act=").append(mAction)
                first = false
            }
            val mCategories = intent.categories
            if (mCategories != null) {
                if (!first) {
                    sb.append(' ')
                }
                first = false
                sb.append("cat=[")
                var firstCategory = true
                for (c in mCategories) {
                    if (!firstCategory) {
                        sb.append(',')
                    }
                    sb.append(c)
                    firstCategory = false
                }
                sb.append("]")
            }
            val mData = intent.data
            if (mData != null) {
                if (!first) {
                    sb.append(' ')
                }
                first = false
                sb.append("dat=").append(mData)
            }
            val mType = intent.type
            if (mType != null) {
                if (!first) {
                    sb.append(' ')
                }
                first = false
                sb.append("typ=").append(mType)
            }
            val mFlags = intent.flags
            if (mFlags != 0) {
                if (!first) {
                    sb.append(' ')
                }
                first = false
                sb.append("flg=0x").append(Integer.toHexString(mFlags))
            }
            val mComponent = intent.component
            if (mComponent != null) {
                if (!first) {
                    sb.append(' ')
                }
                first = false
                sb.append("cmp=").append(mComponent.flattenToShortString())
            }
            val mSourceBounds = intent.sourceBounds
            if (mSourceBounds != null) {
                if (!first) {
                    sb.append(' ')
                }
                first = false
                sb.append("bnds=").append(mSourceBounds.toShortString())
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                val mClipData = intent.clipData
                if (mClipData != null) {
                    if (!first) {
                        sb.append(' ')
                    }
                    first = false
                    clipData2String(mClipData, sb)
                }
            }
            val mExtras = intent.extras
            if (mExtras != null) {
                if (!first) {
                    sb.append(' ')
                }
                first = false
                sb.append("extras={")
                sb.append(bundle2String(mExtras))
                sb.append('}')
            }
            if (Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.ICE_CREAM_SANDWICH_MR1) {
                val mSelector = intent.selector
                if (mSelector != null) {
                    if (!first) {
                        sb.append(' ')
                    }
                    first = false
                    sb.append("sel={")
                    sb.append(
                            if (mSelector === intent) "(this Intent)" else intent2String(mSelector)
                    )
                    sb.append("}")
                }
            }
            sb.append(" }")
            return sb.toString()
        }

        @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
        private fun clipData2String(clipData: ClipData, sb: StringBuilder) {
            val item = clipData.getItemAt(0)
            if (item == null) {
                sb.append("ClipData.Item {}")
                return
            }
            sb.append("ClipData.Item { ")
            val mHtmlText = item.htmlText
            if (mHtmlText != null) {
                sb.append("H:")
                sb.append(mHtmlText)
                sb.append("}")
                return
            }
            val mText = item.text
            if (mText != null) {
                sb.append("T:")
                sb.append(mText)
                sb.append("}")
                return
            }
            val uri = item.uri
            if (uri != null) {
                sb.append("U:").append(uri)
                sb.append("}")
                return
            }
            val intent = item.intent
            if (intent != null) {
                sb.append("I:")
                sb.append(intent2String(intent))
                sb.append("}")
                return
            }
            sb.append("NULL")
            sb.append("}")
        }

        private fun array2String(obj: Any): String {
            if (obj is Array<*>) {
                return Arrays.deepToString(obj)
            } else if (obj is BooleanArray) {
                return Arrays.toString(obj)
            } else if (obj is ByteArray) {
                return Arrays.toString(obj)
            } else if (obj is CharArray) {
                return Arrays.toString(obj)
            } else if (obj is DoubleArray) {
                return Arrays.toString(obj)
            } else if (obj is FloatArray) {
                return Arrays.toString(obj)
            } else if (obj is IntArray) {
                return Arrays.toString(obj)
            } else if (obj is LongArray) {
                return Arrays.toString(obj)
            } else if (obj is ShortArray) {
                return Arrays.toString(obj)
            }
            throw IllegalArgumentException("Array has incompatible type: " + obj.javaClass)
        }
    }

    private fun getClassFromObject(obj: Any): Class<*> {
        val objClass = obj.javaClass
        if (objClass.isAnonymousClass || objClass.isSynthetic) {
            val genericInterfaces = objClass.genericInterfaces
            var className: String
            className =
                    if (genericInterfaces.size == 1) { // interface
                        var type = genericInterfaces[0]
                        while (type is ParameterizedType) {
                            type = type.rawType
                        }
                        type.toString()
                    } else { // abstract class or lambda
                        var type = objClass.genericSuperclass
                        while (type is ParameterizedType) {
                            type = type.rawType
                        }
                        type.toString()
                    }
            if (className.startsWith("class ")) {
                className = className.substring(6)
            } else if (className.startsWith("interface ")) {
                className = className.substring(10)
            }
            return try {
                Class.forName(className)
            } catch (e: ClassNotFoundException) {
                e.printStackTrace()
                objClass
            }
        }
        return objClass
    }
}
