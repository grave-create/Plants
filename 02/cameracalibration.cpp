#include "cameracalibration.h"
Cameracalibration::Cameracalibration(QObject *parent) : QObject(parent)
{

}


QList<QString> Cameracalibration::getFilename()
{
    QList<QString> Array;
    for(int i=0;i<images.size();i++)
    {
        Array.push_back(QString::fromStdString(images[i]));
    }
    return Array;
}
//输入视频
void Cameracalibration::photoCapture(QString file)
{
    cout<<file.toStdString()<<endl;
    //string filename1="D:/image/1.mp4";
    cap.open(file.toStdString());//filename
    if (!cap.isOpened())
        return;
}
//图片分解、保存
void Cameracalibration::outImages(QString output)
{
    Mat srcImg;
    cap >> srcImg;
    int countnums = 0,num = 1;
    //string folderPath = imagesname;//构建一个指定文件夹存放照片
    //string command;
    //command = "mkdir -p " + folderPath;
    //system(command.c_str());
    imagesname=output.toStdString()+"/";
    while (!srcImg.empty())
    {
        string output = imagesname + "Image_" + to_string(num) + ".jpg";//图片输出处
        if (countnums % interval == 0)
        {
            images.push_back(output);
            imwrite(output, srcImg);
            num++;
        }
        countnums++;
        cap >> srcImg;
    }
}
//删除图片帧
void Cameracalibration::deleteImage(int index)
{
    // 删除图片文件
    QFile fileTemp(QString::fromStdString(images[index]));
    fileTemp.remove();
    //将其从数组中删除
    std::vector<string>::iterator it = images.begin()+index;
      images.erase(it);
}
