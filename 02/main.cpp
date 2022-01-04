#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QCoreApplication>
#include <QtWidgets>
#include <QQmlContext>
#include <QtMultimedia>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/features2d/features2d.hpp> //引用cv::KeyPoint 特征检测器通用接口
#include <opencv2/calib3d/calib3d.hpp>
#include  <iostream>
#include <iomanip>
#include <fstream>
#include "CameraCalibrator.h"
#include "cameracalibration.h"
using namespace std;
using namespace cv;
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Cameracalibration temp;
    engine.rootContext()->setContextProperty("temp", &temp);
    //qmlRegisterType<CameraCalibrator>("Sources.CameraCalibrator", 1, 0, "CAMERA");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    CameraCalibrator cameracalibrator;
    engine.rootContext()->setContextProperty("CameraCalibrator", &cameracalibrator);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
