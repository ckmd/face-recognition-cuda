#include <iostream>
#include <cstdlib>
#include <math.h>
#define epoch 100000000
using namespace std;

int rand();
double RandomNumber(double Min, double Max)
{
    return ((double(rand()) / double(RAND_MAX)) * (Max - Min)) + Min;
}


double sigmoid(double x){
    return 1 / (1 + exp(-x));
}

double sigmoid_der(double x){
    return sigmoid(x) * (1 - sigmoid(x));
}

float * dot_matrix(float m1[3], float m2[3]){
    static float C[1];

    C[0] = 0;
    for (int j = 0; j < 3; j++){
        C[0] +=  m1[j] * m2[j];
    }
    return C;
}

float weight[3];
float bias = RandomNumber(-1,1);
float learning_rate = 0.05;
float *inputs, suminput, activation1;
float error, dcost_dpred, dpred_dz, z_delta;
int ri;
double sum_error = 0;

void testing(float in[]){
    inputs = dot_matrix(in, weight);
    suminput = inputs[0] + bias;
    activation1 = sigmoid(suminput);
    cout << activation1 << endl;
}

int main(){

    cout << "Neural Network Start" << endl;
    float feature_set[5][3] = {{0,1,0},{0,0,1},{1,0,0},{1,1,0},{1,1,1}};
    float label[5][1] = {{1},{0},{0},{1},{1}};

    // filling weight with random number
    for(int i = 0; i < 3; i++){
        weight[i] = RandomNumber(-1, 1);
    }
    // Training Phase
    cout << "Training Section" << endl;
    for(int i = 0; i < epoch; i++){
        ri = rand() % 5;

        inputs = dot_matrix(feature_set[ri], weight);
        suminput = inputs[0] + bias;
        activation1 = sigmoid(suminput);

        error = activation1 - label[ri][0];

        dcost_dpred = error;
        dpred_dz = sigmoid_der(activation1);
        z_delta = dcost_dpred * dpred_dz;

        for(int j = 0; j < 3; j++){
            weight[j] -= (learning_rate * feature_set[ri][j] * z_delta);
        }
        bias -= learning_rate * z_delta;
        sum_error += error;

        if(i % 10000000 == 0 && i > 0){
            cout << "Epoch " << i << " error : " << sum_error / (i+1) << endl;
        }

    }
    cout << "Testing Section" << endl;
    for(int i = 0; i < 5; i++)
        testing(feature_set[i]);

    return 0;
}
