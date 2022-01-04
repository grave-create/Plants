#ifndef CAMERACALIBRATOR_H
#define CAMERACALIBRATOR_H
#pragma once
#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/features2d/features2d.hpp> //引用cv::KeyPoint 特征检测器通用接口
#include <opencv2/calib3d/calib3d.hpp>
#include  <iostream>
#include <iomanip>
#include <fstream>
#include <QObject>
using namespace std;
using namespace cv;

class CameraCalibrator:public QObject
{
    Q_OBJECT
public:
     Size board_size;    /* 标定板上每行、列的角点数 */
     Size square_size;   /* 实际测量得到的标定板上每个棋盘格的大小 */
    //打印内参矩阵每一个元素
    vector<double> cameraMatrix_vec;//保存内参矩阵的参数vector
    vector<double> distCoeffs_vec;//保存畸变系数的vector
signals:

public slots:
    void setBoardSize(QString bx,QString by,QString sx,QString sy);
    void CarmeraCalibrate();
    vector<double> getCameraMatrix();
    vector<double> getDistCoeffs();
    QStringList getFileNames(const QString &path);

};

#endif // CAMERACALIBRATOR_H
