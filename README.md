# QtTemplateApp介绍
qt项目模板，qmake，持续更新完善
Pro文件为qt项目管理文件，可以满足我们开发过程中的项目配置需求。本文旨在生成一个功能完善的Qt项目文件模板，重点是pro文件通用配置，希望最终能够拿来就用，为各位同仁节省更多时间专注于业务开发。有了此项目你只需放开或者屏蔽一些内容即可创建你想要的项目。

# 开源地址
github地址：https://github.com/nealwang123/QtTemplateApp.git

gitee地址：https://gitee.com/nealwang2021/qt-template-app.git

# Pro文件关键字简要介绍
    QT += core gui :添加QT需要的模块
    TARGET = TemplateApp：生成最后目标的名字
    TEMPLATE =app：应用程序的生成模式，默认是app生成应用程序，如果需要生成库的话就用lib
    CONFIG +=debug：一些配置信息，如C++版本，编译模式debug或release等
    HEADERS +=：工程用到的头文件
    SOURCES +=：工程用到的源文件
    LIBS += -L$$OUT_PWD/../funDll/ -lfunDll：工程依赖的库
    DESTDIR +=：目标生成路径
    INCLUDEPATH += $$PWD/../mydll ：编译时#include需要搜索的目录
    DEPENDPATH +=：工程的依赖路径，qmake会扫描这些目录以查找依赖项
    FORMS +=：工程中的ui文件
    PWD：当前.pro文件所在的路径
    OUT_PWD：Makefile所在的路径
    QT是跨平台的，所以我们在不同的平台上用同一个Pro文件，这要加入有关平台的信息。
    win32｛
    ｝
    unix｛
    ｝

# Pro文件模板完善

## Qt5支持在Pro文件中写上版本号、程序图标、产品名称、版权所有、文件说明等信息
在windows上qmake的时会自动将此信息转换成rc文件。对于早期的Qt4版本你可以手动写rc文件实现。  

```
#程序版本
VERSION = 2035.10.01
#程序图标
RC_ICONS = main.ico
#产品名称
QMAKE_TARGET_PRODUCT = QtTemplateApp
#版权所有
QMAKE_TARGET_COPYRIGHT = 某某科技
#文件说明
QMAKE_TARGET_DESCRIPTION = 台湾是中国不可分割的一部分
```

## 添加管理员权限
以管理员权限运行程序，限定在MSVC编译器，在项目Pro文件中增加如下代码。  重新编译之后，程序会带个盾牌标志。但是会有个后遗症，会发现我们在debug下，无法进行调试了，会弹出"The CDB process terminated"的错误；这是因为我们的QtCreator没有以管理员权限运行，却对管理员权限的程序进行调试。当重新以管理员权限运行QtCreator，并进行调试，就不会报错了。

```
#以管理员运行
QMAKE_LFLAGS += /MANIFESTUAC:"level='requireAdministrator' uiAccess='false'" 
#VS2013 在XP运行 未验证
#QMAKE_LFLAGS += /SUBSYSTEM:WINDOWS,"5.01" 
```

## 指定临时文件生成

```
#指定编译生成的文件到temp目录 分门别类存储
MOC_DIR = temp/moc
RCC_DIR = temp/rcc
UI_DIR = temp/ui
OBJECTS_DIR = temp/obj
```

## 指定编译生成的可执行文件到bin目录
```
#指定编译生成的可执行文件到bin目录
DESTDIR = bin
```

## 运行文件附带启动调试输出窗口
`CONFIG += console`
## 判断Qt版本及构建套件位数  

```
#打印版本信息
message(qt version: $$QT_VERSION)
#判断当前qt版本号
QT_VERSION = $$[QT_VERSION]
QT_VERSION = $$split(QT_VERSION, ".")
QT_VER_MAJ = $$member(QT_VERSION, 0)
QT_VER_MIN = $$member(QT_VERSION, 1)
#下面是表示 Qt5.5及以上版本
greaterThan(QT_VER_MAJ, 4) {
greaterThan(QT_VER_MIN, 4) {
#自己根据需要做一些处理
}}
#QT_ARCH是Qt5新增的,在Qt4上没效果
#打印当前Qt构建套件的信息
message($$QT_ARCH)
#表示arm平台构建套件
contains(QT_ARCH, arm) {}
#表示32位的构建套件
contains(QT_ARCH, i386) {}
#表示64位的构建套件
contains(QT_ARCH, x86_64) {}
#其实Qt内置了主版本号和子版本号变量
#判断当前qt版本号
message($$QT_ARCH : $$QT_VERSION -> $$QT_MAJOR_VERSION . $$QT_MINOR_VERSION)
#下面的含义是如果版本 < 4.8
lessThan(QT_MAJOR_VERSION, 5) {
lessThan(QT_MINOR_VERSION, 8) {
#这里放要做的处理
}}
#下面的含义是如果版本 < 5.12.0
REQ_QT_MAJOR = 5
REQ_QT_MINOR = 12
REQ_QT_PATCH = 0
lessThan(QT_MAJOR_VERSION, $$REQ_QT_MAJOR)|lessThan(QT_MINOR_VERSION,
$$REQ_QT_MINOR)|lessThan(QT_MINOR_VERSION, $$REQ_QT_PATCH) {
#这里放要做的处理
}
#下面的含义是如果版本 >= 5.5
greaterThan(QT_MAJOR_VERSION, 4) {
greaterThan(QT_MINOR_VERSION, 4) {
#这里放要做的处理
}}
//代码中判断版本不要太简单
#if (QT_VERSION >= QT_VERSION_CHECK(6,0,0))
//这里放要做的处理
#endif
//下面表示 >= 5.0.0
#if QT_VERSION >= 0x050000
...
#endif
//下面表示 < 5.12.10
#if QT_VERSION < 0x050C0A
...
#endif
```

## 直接Pro中来禁用整个项目的qdebug输出  
#禁用qdebug打印输出
DEFINES += QT_NO_DEBUG_OUTPUT

## 设置Release模式可调试
法一

```
QMAKE_CXXFLAGS_RELEASE = $$QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO
QMAKE_LFLAGS_RELEASE = $$QMAKE_LFLAGS_RELEASE_WITH_DEBUGINFO
```

法二

```
# QMAKE *.pro-file: release模式下禁用优化并开启调试功能
#
# gcc
#QMAKE_CXXFLAGS_RELEASE += -O0 -g
#QMAKE_CFLAGS_RELEASE += -O0 -g
#QMAKE_LFLAGS_RELEASE =
 
# msvc(VS调试模式，在VS2015 + QT5.6.3环境下调试通过)
QMAKE_CXXFLAGS_RELEASE += /Zi
QMAKE_CXXFLAGS_RELEASE += /Od
QMAKE_LFLAGS_RELEASE += /DEBUG
```

## QDebug统一控制

```
DEFINES +=QT_NO_DEBUG_OUTPUT # disable debug output
DEFINES -=QT_NO_DEBUG_OUTPUT # enable debug output
```

## Qt的Pro项目管理配置文件中也可添加各种编译前后的操作及配置
qt主要通过 QMAKE_POST_LINK 和QMAKE_PRE_LINK，他们支持的函数以及写法，可以在QtCreator的帮助中搜索 qmake Function Reference 查看详情说明。  

```
srcFile1 = $$PWD/1.txt
srcFile2 = $$PWD/2.txt
dstDir = $$PWD/../bin
#windows上需要转换路径斜杠 其他系统不需要
srcFile1 = $$replace(srcFile1, /, \\);
srcFile2 = $$replace(srcFile2, /, \\);
dstDir = $$replace(dstDir, /, \\);
#编译前执行拷贝 多个拷贝可以通过 && 符号隔开
QMAKE_PRE_LINK += copy /Y $$srcFile1 $$dstDir && copy /Y $$srcFile2 $$dstDir
#编译后执行拷贝 多个拷贝可以通过 && 符号隔开
QMAKE_POST_LINK += copy /Y $$srcFile1 $$dstDir && copy /Y $$srcFile2
$$dstDir
```

## 根据操作系统位数判断加载  

```
win32 {
    contains(DEFINES, WIN64) {
    	DESTDIR = $$PWD/../bin64
    } else {
    	DESTDIR = $$PWD/../bin32
    }
}
```


//解决UTF-8编码中文乱码的问题
#ifdef _MSC_VER
#if _MSC_VER >= 1600
#pragma execution_character_set("utf-8")
#pragma warning(disable : 4819)
#endif // _MSC_VER >= 1600
#endif // _MSC_VER

# 参考链接
https://doc.qt.io/qt-5/qmake-manual.html

https://doc.qt.io/qt-5/qmake-project-files.html

https://doc.qt.io/qt-5/qmake-language.html

https://doc.qt.io/qt-5/qmake-common-projects.html

https://doc.qt.io/qt-5/qmake-precompiledheaders.html

https://doc.qt.io/qt-5/qmake-test-function-reference.html

https://libaineu2004.blog.csdn.net/article/details/89366925
