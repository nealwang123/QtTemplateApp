QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET      = QtTemplateApp
TEMPLATE    = app

#自定义程序信息
#程序版本
VERSION = 1.0.1
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


#目标文件目录
Debug:{
    TARGET = TemplateApp
    DESTDIR  = ./build/debug
    TEMP_DESTDIR = ./build/temp/debug/$$TARGET
}

Release:{
    TARGET = TemplateApp
    DESTDIR  = ./build/release
    TEMP_DESTDIR = ./build/temp/release/$$TARGET
}
#指定编译生成的文件到temp目录 分门别类存储
MOC_DIR         = $$TEMP_DESTDIR/moc
RCC_DIR         = $$TEMP_DESTDIR/rcc
UI_DIR          = $$TEMP_DESTDIR/qui
OBJECTS_DIR     = $$TEMP_DESTDIR/obj

#C++标准
CONFIG += c++11
#控制台分离输出
CONFIG += console

#编译优化
msvc:CONFIG(release, debug|release) {
    QMAKE_CFLAGS_RELEASE   -= -O2              # 取消C优化
    QMAKE_CFLAGS_RELEASE   += -Zi              # 生成调试信息，放到pdb文件中
    QMAKE_CXXFLAGS_RELEASE -= -O2              # 取消C++优化
    QMAKE_CXXFLAGS_RELEASE += -Zi              # 生成调试信息
    QMAKE_LFLAGS_RELEASE   -= /INCREMENTAL:NO  # 选择增量链接
    QMAKE_LFLAGS_RELEASE   += /DEBUG           # 将调试信息放到PDB文件中
    message( MSVC Release )
}

mingw:CONFIG(release, debug|release) {
    QMAKE_CFLAGS_RELEASE   -= -O2              # 取消C优化
    QMAKE_CFLAGS_RELEASE   += -O0              # 显示指定禁止优化
    QMAKE_CFLAGS_RELEASE   += -g               # 生成C调试信息
    QMAKE_CXXFLAGS_RELEASE -= -O2              # 取消C++优化
    QMAKE_CXXFLAGS_RELEASE += -O0              # 显示指定禁止优化
    QMAKE_CXXFLAGS_RELEASE += -g               # 生成C++调试信息
    QMAKE_LFLAGS_RELEASE   -= -Wl,-s           # 取消Release模式删除所有符号表和重新定位信息的设置
    QMAKE_LFLAGS_RELEASE   += -g               # 链接器生成调试信息
    message( Mingw release)
}

# 如果不加unix，MinGW也会进入这里
unix:gcc:CONFIG(release, debug|release) {
    QMAKE_CFLAGS_RELEASE   -= -O2              # 取消C优化
    QMAKE_CFLAGS_RELEASE   += -O0              # 显示指定禁止优化
    QMAKE_CFLAGS_RELEASE   += -g               # 生成C调试信息
    QMAKE_CXXFLAGS_RELEASE -= -O2              # 取消C++优化
    QMAKE_CXXFLAGS_RELEASE += -O0              # 显示指定禁止优化
    QMAKE_CXXFLAGS_RELEASE += -g               # 生成C++调试信息
    QMAKE_LFLAGS_RELEASE   -= -Wl,-O1          # 取消Release模式链接器优化
    QMAKE_LFLAGS_RELEASE   += -g               # 链接器生成调试信息
    message( GCC Release )
}

*msvc* {
    QMAKE_CXXFLAGS += /MP #使用多线程库
}
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

#中文乱码
msvc {
    QMAKE_CFLAGS += /utf-8
    QMAKE_CXXFLAGS += /utf-8
}
