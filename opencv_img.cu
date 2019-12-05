#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/opencv.hpp>
#include <iostream>
#include <typeinfo>
#include <string>
#include <dirent.h>
#include "gabor.h"

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

int main()
{
    struct ImageData { 
        int imgArray[100][100];
    } data;

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
        cout << name;
        // Converting image from RGB into greyscale
        Mat grey;
        cvtColor( img, grey, CV_BGR2GRAY );
        
        // resizing image into 100x100
        Mat grey100;
        resize(grey, grey100, Size(100,100));
        imshow("test", grey100);
        waitKey(100);
        
        // converting Mat image into array
        for(int i = 0; i < grey100.rows; i++){
            for(int j = 0; j < grey100.cols; j++){
                data.imgArray[i][j] = (int)grey100.at<uchar>(i,j);
            }
        }
        labels.push_back(label);
        datas.push_back(data);
        cout << label[0] << " " << data.imgArray[0][0] << endl;
    }
    cout << labels.size() << " " << datas.size() << endl;
    // float (*map5)[maxMap][maxMap];
    // float min = load;
    // float map6 = map5[0][0][0];
    return 0;
}