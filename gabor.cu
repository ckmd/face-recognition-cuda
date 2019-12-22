#include <iostream>
#include <cmath>
#include <math.h>
#include "gabor.h"

using namespace std;
// const int maxMap = 33;

double changeBaseX(double x, double y, double theta){
    double x_theta = x * cos(theta) + y * sin(theta);
    return x_theta;
}

double changeBaseY(double x, double y, double theta){
    double y_theta = y * cos(theta) - x * sin(theta);
    return y_theta;
}

double GaborFunction(double x, double y, double theta, double f, double sigma_x, double sigma_y){
    double r1 = changeBaseX(x,y,theta) / sigma_x;
    double r2 = changeBaseY(x,y,theta) / sigma_y;
    double arg = - 0.5 * ( pow(r1,2) + pow(r2,2) );
    return exp(arg) * cos(2*M_PI*f*changeBaseX(x,y,theta));
}

double GaborFunctionImajiner(double x, double y, double theta, double f, double sigma_x, double sigma_y){
    double r1 = changeBaseX(x,y,theta) / sigma_x;
    double r2 = changeBaseY(x,y,theta) / sigma_y;
    double arg = - 0.5 * ( pow(r1,2) + pow(r2,2) );
    return exp(arg) * sin(2*M_PI*f*changeBaseX(x,y,theta));
}

void *gabor(int radius, double freq, double sig_x, double sig_y){
    int area = radius*2+1;
    double (*M)[maxMap][maxMap] = new double[4][maxMap][maxMap];
    int id = 0;
    for(double theta = 0.0; theta < 180.0; theta += 45.0){
        double x = -(double)radius;
//        cout << theta << endl;
        for(int i = 0; i < area; i++){
            double y = -(double)radius;
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

void *gaborImajiner(int radius, double freq, double sig_x, double sig_y){
    int area = radius*2+1;
    double (*M)[maxMap][maxMap] = new double[4][maxMap][maxMap];
    int id = 0;
    for(double theta = 0.0; theta < 180.0; theta += 45.0){
        double x = -(double)radius;
//        cout << theta << endl;
        for(int i = 0; i < area; i++){
            double y = -(double)radius;
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


double (*map5)[maxMap][maxMap] = ( double (*)[maxMap][maxMap])gabor(2, 0.6, 1.25, 1.25);
double (*map9)[maxMap][maxMap] = ( double (*)[maxMap][maxMap]) gabor(4, 0.44, 1.45, 1.45);
double (*map17)[maxMap][maxMap] = ( double (*)[maxMap][maxMap]) gabor(8, 0.22, 2.7, 2.7);
double (*map33)[maxMap][maxMap] = ( double (*)[maxMap][maxMap]) gabor(16, 0.12, 5.1, 5.1);

double (*map5i)[maxMap][maxMap] = ( double (*)[maxMap][maxMap]) gaborImajiner(2, 0.6, 1.25, 1.25);
double (*map9i)[maxMap][maxMap] = ( double (*)[maxMap][maxMap]) gaborImajiner(4, 0.44, 1.45, 1.45);
double (*map17i)[maxMap][maxMap] = ( double (*)[maxMap][maxMap]) gaborImajiner(8, 0.22, 2.7, 2.7);
double (*map33i)[maxMap][maxMap] = ( double (*)[maxMap][maxMap]) gaborImajiner(16, 0.12, 5.1, 5.1);