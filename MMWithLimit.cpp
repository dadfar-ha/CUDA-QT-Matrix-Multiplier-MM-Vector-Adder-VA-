#include "MMWithLimit.h"
#include "cuda_runtime.h"
#include "qelapsedtimer.h"
#include "MMWithLimitCuda.cuh"
#include <QRandomGenerator>
#include <QtGlobal>
#include<math.h>


MMWithLimit::MMWithLimit(QObject *parent) : QObject(parent)
{
}

void *MMWithLimit::addVectorsCPU(double *a, double *b, int n)//adding function of cpu
{
    for (int i = 0; i < n; ++i)
        b[i] = a[i] + b[i];
    return b;
}

double *MMWithLimit::genRanVec(int n) //Creating a random array (0-1)
{
    double* v = (double*)malloc(n * sizeof(double));
    for (int i = 0; i < n; ++i)
        v[i] = valueOfMatrices;//QRandomGenerator::global()->generateDouble()
    return v;
}


void MMWithLimit::functionCuda()
{
    int n = sizeOfMatrice;
    double* A = genRanVec(n*n);
    double* B = genRanVec(n*n);
    C[sizeOfMatrice * sizeOfMatrice];

    auto t = std::chrono::high_resolution_clock::now();//saving first time instance
    kernel(A, B, C, n);// functiion of cuda
    auto gpuTimeMs = (double) std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now() - t).count() / 1e6;//saving the whole time of cuda function duration

    qDebug()<<"C"<<C[0];
    emit setGreenGPU();
    emit timeGPU(gpuTimeMs);
}

void MMWithLimit::functionNoCuda()
{
    srand(time(NULL));

    int N = sizeOfMatrice;
    QVector<int> matrix1(N * N);
    QVector<int> matrix2(N * N);
    QVector<int> result(N * N);

    // Fill the matrices with random values
    for (int i = 0; i < N * N; ++i) {
        matrix1[i] = 1;
        matrix2[i] = 1;
    }

    auto t = std::chrono::high_resolution_clock::now();//saving first time instance
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            int sum = 0;
            for (int k = 0; k < N; ++k) {
                sum += matrix1[i * N + k] * matrix2[k * N + j];
            }
            result[i * N + j] = sum;
        }
    }
    auto gpuTimeMs = (double)std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now() - t).count() / 1e6;//saving the whole time of cuda function duration


    emit setGreenCPU();
    emit timeCPU(gpuTimeMs);
}

void MMWithLimit::setSizeMatrices(QVariant size)
{
    sizeOfMatrice=size.toInt();
}

void MMWithLimit::seteMatricesValue(QVariant value)
{
    qDebug()<<"value"<<value;
    if(value.toDouble()==0){
        valueOfMatrices=QRandomGenerator::global()->generateDouble();
    }
    else
        valueOfMatrices=value.toDouble();
}

void MMWithLimit::minMaxSendTo(QVariant value, QVariant obj)
{
    if (obj.toString()=="Min")
        min=value.toInt();
    else if(obj.toString()=="Max")
        max=value.toInt();
}

void MMWithLimit::startShowResult()
{
    for (int i=min;i<max;++i){
        sendResults(C[i]);
    }
}
