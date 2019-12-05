#include <iostream>
#include "convolution.h"

using namespace std;

const int filterSize = 33;

void conv(ImageData num, float a[4][33][33]){
    int num_height = sizeof(num.imgArray)/sizeof(num.imgArray[0]);
    int num_width = sizeof(num.imgArray[0])/sizeof(num.imgArray[0][0]);

    float feature_maps[num_height-filterSize+1][num_width-filterSize+1][4];
    // cout << "conv function" << sizeof(a[0])/sizeof(a[0][0]) << endl;
    for(int i = 0; i < 4; i++){
        for(int j = 0; j < filterSize; j++){
            for(int k = 0; k < filterSize; k++){}
            // cout << a[i][j][k] << "\t";
        // cout << endl;
        }
    // cout << endl;
    }
}