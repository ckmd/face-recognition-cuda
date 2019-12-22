#include <iostream>
#include "convolution.h"

using namespace std;

const int filterSize = 33;

void *conv(ImageData num, double filter[4][33][33]){
    int num_height = sizeof(num.imgArray)/sizeof(num.imgArray[0]);
    int num_width = sizeof(num.imgArray[0])/sizeof(num.imgArray[0][0]);

    // float feature_maps[num_height-filterSize+1][num_width-filterSize+1][4];
    double (*result)[100][100] = new double[4][100][100];

    // double result[4][num_height-32][num_width-32];
    for(int i = 0; i < 4; i++){
        // Real convoluting happen here
        // changable for numpy.zeros
        for(int j = 0; j < num_height-32; j++){
            for(int k = 0; k < num_width-32; k++){
                result[i][j][k] = 0;
            }
            // cout << j << endl;
        }
        // disini tidak ditambah 1
        for(int r = filterSize/2.0; r < num_height-filterSize/2.0; r++){
            for(int c = filterSize/2.0; c < num_width-filterSize/2.0; c++){
                double curr_region[filterSize][filterSize];
                double sum = 0;
                int filterr = 0;
                for(int regionr = r-filterSize/2.0; regionr < r+filterSize/2.0-2; regionr++){
                    int filterc = 0;
                    for(int regionc = c-filterSize/2.0; regionc < c+filterSize/2.0-2; regionc++){
                        // cout << regionr << " " << regionc << " " << filterr << " " << filterc << endl;
                        // break;
                        curr_region[filterr][filterc] = num.imgArray[regionr][regionc] * filter[i][filterr][filterc];
                        sum += curr_region[filterr][filterc];
                        // cout << curr_region[regionr][regionc] << endl;
                        filterc++;
                    }
                    filterr++; 
                    // break;
                }
                result[i][r-16][c-16] = sum;
                // break;
            }
            // break;
        }
        // break;
    }
    return result;
    // return feature_maps;
}

void *pooling(){
    int stride = 2;
    int size = 2;
    int r2 = 0;
    for(int ro = 0; ro < height-size+1; ro+=stride){
        int c2 = 0;
        for(int co = 0; co < width-size+1; co+=stride){
            pool_out[r2,c2] = max(feature_maps[ro:ro+size, co:co+size]);
            
            c2++;
        }
    r2++;
    }
}