#include <iostream>
#include <cmath>
#include <math.h>
#include "gabor.h"

using namespace std;
// const int maxMap = 33;

float changeBaseX(float x, float y, float theta){
    float x_theta = x * cos(theta) + y * sin(theta);
    return x_theta;
}

float changeBaseY(float x, float y, float theta){
    float y_theta = y * cos(theta) - x * sin(theta);
    return y_theta;
}

float GaborFunction(float x, float y, float theta, float f, float sigma_x, float sigma_y){
    float r1 = changeBaseX(x,y,theta) / sigma_x;
    float r2 = changeBaseY(x,y,theta) / sigma_y;
    float arg = - 0.5 * ( pow(r1,2) + pow(r2,2) );
    return exp(arg) * cos(2*M_PI*f*changeBaseX(x,y,theta));
}

float GaborFunctionImajiner(float x, float y, float theta, float f, float sigma_x, float sigma_y){
    float r1 = changeBaseX(x,y,theta) / sigma_x;
    float r2 = changeBaseY(x,y,theta) / sigma_y;
    float arg = - 0.5 * ( pow(r1,2) + pow(r2,2) );
    return exp(arg) * sin(2*M_PI*f*changeBaseX(x,y,theta));
}

void *gabor(int radius, float freq, float sig_x, float sig_y){
    int area = radius*2+1;
    float (*M)[maxMap][maxMap] = new float[4][maxMap][maxMap];
    int id = 0;
    for(float theta = 0.0; theta < 180.0; theta += 45.0){
        float x = -(float)radius;
//        cout << theta << endl;
        for(int i = 0; i < area; i++){
            float y = -(float)radius;
            for(int j = 0; j <area; j++){
                M[id][i][j] = 0;
                M[id][i][j] = GaborFunction(x,y,theta*M_PI/180,freq,sig_x,sig_y);
                y = y + 1;
//                cout << M[id][i][j] << "\t";
            }
//            cout << endl;
            x = x + 1;
        }
    id = id + 1;
//    cout << endl;
    }
    return M;
}

void *gaborImajiner(int radius, float freq, float sig_x, float sig_y){
    int area = radius*2+1;
    float (*M)[maxMap][maxMap] = new float[4][maxMap][maxMap];
    int id = 0;
    for(float theta = 0.0; theta < 180.0; theta += 45.0){
        float x = -(float)radius;
//        cout << theta << endl;
        for(int i = 0; i < area; i++){
            float y = -(float)radius;
            for(int j = 0; j <area; j++){
                M[id][i][j] = 0;
                M[id][i][j] = GaborFunctionImajiner(x,y,theta*M_PI/180,freq,sig_x,sig_y);
                y = y + 1;
//                cout << M[id][i][j] << "\t";
            }
//            cout << endl;
            x = x + 1;
        }
    id = id + 1;
//    cout << endl;
    }
    return M;
}


float (*map5)[maxMap][maxMap] = ( float (*)[maxMap][maxMap])gabor(2, 0.6, 1.25, 1.25);
float (*map9)[maxMap][maxMap] = ( float (*)[maxMap][maxMap]) gabor(4, 0.44, 1.45, 1.45);
float (*map17)[maxMap][maxMap] = ( float (*)[maxMap][maxMap]) gabor(8, 0.22, 2.7, 2.7);
float (*map33)[maxMap][maxMap] = ( float (*)[maxMap][maxMap]) gabor(16, 0.12, 5.1, 5.1);

float (*map5i)[maxMap][maxMap] = ( float (*)[maxMap][maxMap]) gaborImajiner(2, 0.6, 1.25, 1.25);
float (*map9i)[maxMap][maxMap] = ( float (*)[maxMap][maxMap]) gaborImajiner(4, 0.44, 1.45, 1.45);
float (*map17i)[maxMap][maxMap] = ( float (*)[maxMap][maxMap]) gaborImajiner(8, 0.22, 2.7, 2.7);
float (*map33i)[maxMap][maxMap] = ( float (*)[maxMap][maxMap]) gaborImajiner(16, 0.12, 5.1, 5.1);