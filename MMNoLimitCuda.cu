#include "cuda_runtime.h"
#include <iostream>
#include <chrono>
#include <cmath>
#include <time.h>
#include <iostream>
#include <chrono>



__global__
    void addKernel(double* x, double* y, double* C, int n) {
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

    for (int i = index; i < n * n; i += stride) {
        int row = i / n;
        int col = i % n;

        C[row * n + col] = 0;
        for (int k = 0; k < n; k++) {
            C[row * n + col] += x[row * n + k] * y[k * n + col];
        }
    }
}

__global__
    void addKernel2(double* x, double* y, int n) {
    int threadID = blockDim.x * blockIdx.x + threadIdx.x;

    if (threadID < n) {
        y[threadID] = x[threadID] + y[threadID];
    }
}
extern "C"
    void* addVectorsGPU(double* a, double* b, int n) {
    cudaDeviceSynchronize();

    double* x;
    double* c;

    cudaMalloc(&x, n * n * sizeof(double));
    cudaMemcpy(x, a, n * n * sizeof(double), cudaMemcpyHostToDevice);
    cudaMalloc((void**)&c, n * n * sizeof(double));
    //double* y=x;

    addKernel << < 1024, 1024 >> > (x, x, c, n);


    cudaMemcpy(b, c, n * n * sizeof(double), cudaMemcpyDeviceToHost);

    return b;
}


extern "C"
    void* addVectorsGPU2(double* a, double* b, int n) {
    cudaDeviceSynchronize();

    double* x;

    cudaMalloc(&x, n * sizeof(double));
    cudaMemcpy(x, a, n * sizeof(double), cudaMemcpyHostToDevice);
    double* y=x;

    addKernel2 << < (n - 1) / 1024 + 1, 1024 >> > (x, y, n);


    cudaMemcpy(b, y, n * sizeof(double), cudaMemcpyDeviceToHost);

    return b;
}
