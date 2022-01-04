QT += quick quick3d\
core gui\
widgets \
core gui multimedia multimediawidgets
LIBS += D:\OpenCV-MinGW-Build-OpenCV-4.5.2-x64\x64\mingw\lib\libopencv_*.dll.a
INCLUDEPATH += D:\OpenCV-MinGW-Build-OpenCV-4.5.2-x64\include\
QT += multimedia
CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        CameraCalibrator.cpp \
        cameracalibration.cpp \
        main.cpp

RESOURCES += qml.qrc \
    icon.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    calibdata.txt \
    calibdata_out.txt

HEADERS += \
    CameraCalibrator.h \
    cameracalibration.h
