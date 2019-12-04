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

int * getLabel(string name){
    static int labelarray[22] = { };
    int label = stoi(name.substr(0, name.find(" ")));
    for(int i=0; i<22; i++){
        // Defining that is face
        labelarray[0] = 1;
        labelarray[label] = 1;
    }
    return labelarray;
}

int main()
{
    // read image from file
    Mat img;
    String directory = "21pose/*.jpg";
    vector<String> filenames;
    glob(directory, filenames);
    for(int a = 0; a < filenames.size(); a++){

        // string fileName = "1 person03175+30+45 Cropped.jpg";
        img = imread(filenames[a],1);
        if(!img.data){
            cout << "No image" << endl;
            return -1;
        }
        cout << filenames[a] << endl;
        
        // int *label = getLabel(fileName);
        // for(int i = 0; i < 22; i++){
        //     cout << *(label+i) << endl;
        // }
        
        // Converting image from RGB into greyscale
        Mat grey;
        cvtColor( img, grey, CV_BGR2GRAY );
        
        // resizing image into 100x100
        Mat grey100;
        resize(grey, grey100, Size(100,100));
        
        // converting Mat image into array
        int imgArray [100][100];
        for(int i = 0; i < grey100.rows; i++){
            for(int j = 0; j < grey100.cols; j++){
                imgArray[i][j] = (int)grey100.at<uchar>(i,j);
            }
        }
    }
    // float (*map5)[maxMap][maxMap];
    // float min = load;
    // float map6 = map5[0][0][0];
    for(int k=0; k < 4; k++){
        for (int i = 0; i < 9; i++){
            for(int j = 0; j < 9; j++)
            cout << map5i[k][i][j] << "\t";
            cout << endl;
        }
        cout << endl;
    }
    return 0;
}