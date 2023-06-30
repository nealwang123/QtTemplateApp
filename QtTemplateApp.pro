QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET      = QtTemplateApp
TEMPLATE    = app

#自定义程序信息
#程序版本
VERSION = 2035.10.01
#程序图标
#RC_ICONS = main.ico
#产品名称
QMAKE_TARGET_PRODUCT = QtTemplateApp
#版权所有
QMAKE_TARGET_COPYRIGHT = "某某科技"
#文件说明
QMAKE_TARGET_DESCRIPTION = "台湾是中国不可分割的一部分"
# 中文（简体）
RC_LANG = 0x0804
#指定编译生成的文件到temp目录 分门别类存储
MOC_DIR = temp/moc
RCC_DIR = temp/rcc
UI_DIR = temp/ui
OBJECTS_DIR = temp/obj
#目标文件目录
win32 {
    contains(DEFINES, WIN64) {
        DESTDIR = $$PWD/bin64
    } else {
        DESTDIR = $$PWD/bin32
    }
}
#
CONFIG += c++11
CONFIG += console

# QMAKE *.pro-file: release模式下禁用优化并开启调试功能
# gcc
#QMAKE_CXXFLAGS_RELEASE += -O0 -g
#QMAKE_CFLAGS_RELEASE += -O0 -g
#QMAKE_LFLAGS_RELEASE =
# msvc(VS调试模式，在VS2015 + QT5.6.3环境下调试通过)
#QMAKE_CXXFLAGS_RELEASE += /Zi
#QMAKE_CXXFLAGS_RELEASE += /Od
#QMAKE_LFLAGS_RELEASE += /DEBUG


# DEFINES +=QT_NO_DEBUG_OUTPUT # disable debug output
#DEFINES -=QT_NO_DEBUG_OUTPUT # enable debug output

#禁用qdebug打印输出
#DEFINES += QT_NO_DEBUG_OUTPUT

#设置Release模式可调试
QMAKE_CXXFLAGS_RELEASE = $$QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO
QMAKE_LFLAGS_RELEASE = $$QMAKE_LFLAGS_RELEASE_WITH_DEBUGINFO

#以下为pri引入依赖文件
#INCLUDEPATH += $$PWD/PackTool
#include( $$PWD/PackTool/PackTool.pri )

#引入第三方库
#INCLUDEPATH += $$PWD/thirdpartylib/libqrencode/include
#DEPENDPATH += $$PWD/thirdpartylib/libqrencode/include
#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/thirdpartylib/libqrencode/lib/ -lqrencode
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/thirdpartylib/libqrencode/lib/ -lqrencoded


# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    mainwindow.h

FORMS += \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



#各种编译前后的操作及配置
#srcFile1 = $$PWD/1.txt
#srcFile2 = $$PWD/2.txt
#dstDir = $$PWD/../bin
##windows上需要转换路径斜杠 其他系统不需要
#srcFile1 = $$replace(srcFile1, /, \\);
#srcFile2 = $$replace(srcFile2, /, \\);
#dstDir = $$replace(dstDir, /, \\);
##编译前执行拷贝 多个拷贝可以通过 && 符号隔开
#QMAKE_PRE_LINK += copy /Y $$srcFile1 $$dstDir && copy /Y $$srcFile2 $$dstDir
##编译后执行拷贝 多个拷贝可以通过 && 符号隔开
#QMAKE_POST_LINK += copy /Y $$srcFile1 $$dstDir && copy /Y $$srcFile2 $$dstDir
