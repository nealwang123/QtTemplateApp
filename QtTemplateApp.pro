QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET      = QtTemplateApp
TEMPLATE    = app

#�Զ��������Ϣ
#����汾
VERSION = 2035.10.01
#����ͼ��
#RC_ICONS = main.ico
#��Ʒ����
QMAKE_TARGET_PRODUCT = QtTemplateApp
#��Ȩ����
QMAKE_TARGET_COPYRIGHT = "ĳĳ�Ƽ�"
#�ļ�˵��
QMAKE_TARGET_DESCRIPTION = "̨�����й����ɷָ��һ����"
# ���ģ����壩
RC_LANG = 0x0804
#ָ���������ɵ��ļ���tempĿ¼ ���ű���洢
MOC_DIR = temp/moc
RCC_DIR = temp/rcc
UI_DIR = temp/ui
OBJECTS_DIR = temp/obj
#Ŀ���ļ�Ŀ¼
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

# QMAKE *.pro-file: releaseģʽ�½����Ż����������Թ���
# gcc
#QMAKE_CXXFLAGS_RELEASE += -O0 -g
#QMAKE_CFLAGS_RELEASE += -O0 -g
#QMAKE_LFLAGS_RELEASE =
# msvc(VS����ģʽ����VS2015 + QT5.6.3�����µ���ͨ��)
#QMAKE_CXXFLAGS_RELEASE += /Zi
#QMAKE_CXXFLAGS_RELEASE += /Od
#QMAKE_LFLAGS_RELEASE += /DEBUG


# DEFINES +=QT_NO_DEBUG_OUTPUT # disable debug output
#DEFINES -=QT_NO_DEBUG_OUTPUT # enable debug output

#����qdebug��ӡ���
#DEFINES += QT_NO_DEBUG_OUTPUT

#����Releaseģʽ�ɵ���
QMAKE_CXXFLAGS_RELEASE = $$QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO
QMAKE_LFLAGS_RELEASE = $$QMAKE_LFLAGS_RELEASE_WITH_DEBUGINFO

#����Ϊpri���������ļ�
#INCLUDEPATH += $$PWD/PackTool
#include( $$PWD/PackTool/PackTool.pri )

#�����������
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



#���ֱ���ǰ��Ĳ���������
#srcFile1 = $$PWD/1.txt
#srcFile2 = $$PWD/2.txt
#dstDir = $$PWD/../bin
##windows����Ҫת��·��б�� ����ϵͳ����Ҫ
#srcFile1 = $$replace(srcFile1, /, \\);
#srcFile2 = $$replace(srcFile2, /, \\);
#dstDir = $$replace(dstDir, /, \\);
##����ǰִ�п��� �����������ͨ�� && ���Ÿ���
#QMAKE_PRE_LINK += copy /Y $$srcFile1 $$dstDir && copy /Y $$srcFile2 $$dstDir
##�����ִ�п��� �����������ͨ�� && ���Ÿ���
#QMAKE_POST_LINK += copy /Y $$srcFile1 $$dstDir && copy /Y $$srcFile2 $$dstDir
