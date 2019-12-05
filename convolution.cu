#include <iostream>
#include "convolution.h"

using namespace std;

const int filterSize = 33;

void conv(ImageData num, float filter[4][33][33]){
    int num_height = sizeof(num.imgArray)/sizeof(num.imgArray[0]);
    int num_width = sizeof(num.imgArray[0])/sizeof(num.imgArray[0][0]);

    float feature_maps[num_height-filterSize+1][num_width-filterSize+1][4];

    for(int i = 0; i < 4; i++){
        // Real convoluting happen here
        int result[num_height][num_width];
        for(int j = 0; j < num_height; j++){
            for(int k = 0; k < num_width; k++){
                result[i][j] = 0;
                // cout << j << endl;
            }
        }
        // disini tidak ditambah 1
        for(int r = filterSize/2.0; r < num_height-filterSize/2.0; r++){
            for(int c = filterSize/2.0; c < num_width-filterSize/2.0; c++){
                int curr_region[filterSize][filterSize];
                int filterr = 0;
                for(int regionr = r-filterSize/2.0; regionr < r+filterSize/2.0-1; regionr++){
                    int filterc = 0;
                    for(int regionc = c-filterSize/2.0; regionc < c+filterSize/2.0-1; regionc++){
                        curr_region[regionr][regionc] = num.imgArray[regionr][regionc] * filter[i][filterr][filterc];
                        filterc++;
                    }
                }
                filterr++;
            }
        }
    }
    // return feature_maps;
}