#include "vASlow.h"
#include "cuda_runtime.h"
#include "qelapsedtimer.h"
#include "MMNoLimit.h"
#include <QRandomGenerator>
#include <QtGlobal>
#include<math.h>
extern "C"
    void* addVectorsGPU2(double* a, double* b, int n);

vASlow::vASlow(QObject *parent) : QObject(parent)
{
}

void *vASlow::addVectorsCPU(double *a, double *b, int n)//adding function of cpu
{
    for (int i = 0; i < n; ++i)
        b[i] = a[i] + b[i];
    return b;
}

double *vASlow::genRanVec(int n) //Creating a random array (0-1)
{
    double* v = (double*)malloc(n * sizeof(double));
    for (int i = 0; i < n; ++i)
        v[i] = valueOfMatrices;//QRandomGenerator::global()->generateDouble()
    return v;
}


void vASlow::functionCuda()
{
    int n = sizeOfMatrice;
    double* a = genRanVec(n);
    double* b = genRanVec(n);

    QElapsedTimer timer;
    timer.start();
    addVectorsGPU2(a, b, n);

    qint64 elapsed = timer.elapsed();

    for (int i = 0; i < 512; ++i){
        emit textConsolelog(b[i]);
        qDebug() << "The function took" << b[i];
        }
    emit setGreenGPU();
    emit timeGPU(elapsed);
}

void vASlow::functionNoCuda()
{
    srand(time(NULL));

    int N = sizeOfMatrice;
    QVector<int> matrix1(N);
    QVector<int> matrix2(N);
    QVector<int> result(N);

    // Fill the matrices with random values
    for (int i = 0; i < N; ++i) {
        matrix1[i] = valueOfMatrices;
        matrix2[i] = valueOfMatrices;
    }

    auto t = std::chrono::high_resolution_clock::now();//saving first time instance
    for (int i = 0; i < N; ++i) {
        result[i] = matrix1[i] + matrix2[i];
    }
    auto gpuTimeMs = (double)std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::high_resolution_clock::now() - t).count() / 1e6;//saving the whole time of cuda function duration


    emit setGreenCPU();
    emit timeCPU(gpuTimeMs);
}

void vASlow::setSizeMatrices(QVariant size)
{
    sizeOfMatrice=size.toInt();
}

void vASlow::seteMatricesValue(QVariant value)
{
    qDebug()<<"value"<<value;
    if(value.toDouble()==0){
        valueOfMatrices=QRandomGenerator::global()->generateDouble();
    }
    else
        valueOfMatrices=value.toDouble();
}

void vASlow::minMaxSendTo(QVariant value, QVariant obj)
{
    if (obj.toString()=="Min")
        min=value.toInt();
    else if(obj.toString()=="Max")
        max=value.toInt();
}

void vASlow::startShowResult()
{
    for (int i=min;i<max;++i){
        sendResults(CVA[i]);
    }
}
