#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/opencv.hpp>
#include <iostream>
#include <typeinfo>
#include <string>
#include <dirent.h>
#include "gabor.h"
#include "convolution.h"

using namespace std;
using namespace cv;

vector<int> getLabel(string name){
    vector<int> labelarray (22, 0);
    string label = name.substr(0, name.find(" "));
    if(label != "nonface"){
    //     cout << "face" << label << endl;
        labelarray[0] = 1;
        labelarray[stoi(label)] = 1;
    }
    return labelarray;
}

double randZeroToOne()
{
    return rand() / (RAND_MAX + 1.);
}

struct ImageData { 
    int imgArray[132][132];
};

void conv(ImageData, float[4][maxMap][maxMap]);

int main()
{
    ImageData data;
    vector<String> filenames, filenamespng;
    vector<vector<int>> labels;
    vector<ImageData> datas;
    vector<int> label;

    // read image from file
    Mat img;
    String directory = "21pose/*.jpg";
    String directorypng = "21pose/*.png";
    string name;

    glob(directory, filenames);
    glob(directorypng, filenamespng);

    for(int a = 0; a < filenames.size() + filenamespng.size(); a++){
        if(a < filenames.size()){
            img = imread(filenames[a],1);
            if(!img.data){
                cout << "No image" << endl;
                return -1;
            }
            name = (string)filenames[a].substr(7,filenames[a].length()-1);
            label = getLabel(name);
        }else{
            img = imread(filenamespng[a-filenames.size()],1);
            if(!img.data){
                cout << "No image" << endl;
                return -1;
            }
            name = (string)filenamespng[a-filenames.size()].substr(7,filenamespng[a-filenames.size()].length()-1);
            label = getLabel(name);
        }
        // cout << name;
        // Converting image from RGB into greyscale
        Mat grey;
        cvtColor( img, grey, CV_BGR2GRAY );
        
        // resizing image into 100x100
        Mat grey100;
        resize(grey, grey100, Size(100,100));
        // imshow("test", grey100);
        // waitKey(1);
        
        // converting Mat image into array and add padding 16
        for(int i = 0; i < 132; i++){
            for(int j = 0; j < 132; j++){
                data.imgArray[i][j] = 128;
                if((i >= 16 && i < grey100.rows + 16) && (j >= 16 && j < grey100.cols + 16))
                    data.imgArray[i][j] = (int)grey100.at<uchar>(i,j);
            }
        }
        labels.push_back(label);
        datas.push_back(data);
        // cout << label[0] << " " << data.imgArray[0][0] << endl;
    }
    // cout << labels.size() << " " << datas.size() << endl;
    // float (*map5)[maxMap][maxMap];
    // float min = load;
    // float map6 = map5[0][0][0];

    // Neural Network Start Here
    double (*syn0)[1000] = new double[20000][1000];
    double (*syn1)[22] = new double[1000][22];
    double (*bias0)[1000] = new double[1][1000];
    double (*bias1)[22] = new double[1][22];

    for(int i = 0; i < 20000; i++)
        for(int j = 0; j < 1000; j++)
            syn0[i][j] = 2 * randZeroToOne() - 1;

    for(int i = 0; i < 1000; i++)
        for(int j = 0; j < 22; j++)
            syn1[i][j] = 2 * randZeroToOne() - 1;

    for(int i = 0; i < 1000; i++)
        bias0[0][i] = 2 * randZeroToOne() - 1;

    for(int i = 0; i < 22; i++)
        bias1[0][i] = 2 * randZeroToOne() - 1;
        
    double learning_rate = 0.005;

    // Training start here
    
    for(int i=0; i < 1; i++){
        (double (*)[maxMap][maxMap])conv(data, map33);
        // convolution
        // pooling
        // magnitude
        // phase
        // Forwardprop
        // BackProp
        // update weight
    }
    // save to pickle

    return 0;
}