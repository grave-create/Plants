#ifndef CAMERACALIBRATION_H
#define CAMERACALIBRATION_H
#include <QStringList>
#include <QImage>
#include <QPixmap>
#include <QDir>
#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/imgproc.hpp>
#include "opencv2/calib3d/calib3d.hpp"
#include <opencv2/calib3d/calib3d_c.h>
#include <opencv2\imgproc\types_c.h>
#include <iostream>
#include <string>
#include<iomanip>
#include <vector>
#include <cstdlib>
#include <QObject>
#include <QVector>
#define interval 15
using namespace std;
using namespace cv;

#include <QObject>
#include <QSettings>

class Cameracalibration : public QObject
{
    Q_OBJECT
public:
    explicit Cameracalibration(QObject *parent = nullptr);

    // 使用 Q_INVOKABLE 宏修饰的方法才可以在 QML 中被调用
    Q_INVOKABLE QList<QString> getFilename();
    Q_INVOKABLE void photoCapture(QString file);//照片获取
    Q_INVOKABLE void outImages(QString output);
    Q_INVOKABLE void deleteImage(int index);

signals:

public slots:

private:
    VideoCapture cap;//视频捕捉
    string filename;//视频文件路径
    string imagesname;//图片存放路径
    vector<string>images;
};


Q_DECLARE_METATYPE(QString)
#endif // CAMERACALIBRATION_H
