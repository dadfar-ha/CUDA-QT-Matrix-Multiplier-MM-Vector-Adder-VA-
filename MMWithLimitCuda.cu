#include "cuda_runtime.h"
#include "MMWithLimitCuda.cuh"
#include <iostream>
#include <chrono>
#include <cmath>
#include <time.h>


//YOU CAN SEE YOUR SYSTEM INDEX PROPERTY FOR THE CUDA SETTING BY THIS LINK:
//C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.3\extras\demo_suite\deviceQuery.exe






__global__ void vectorAdditionKernel(double* A, double* B, double* C, int n) {
   
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

    for (int i = index; i < n * n; i += stride) {
        int row = i / n;
        int col = i % n;

        C[row * n + col] = 0;
        for (int k = 0; k < n; k++) {
            C[row * n + col] += A[row * n + k] * B[k * n + col];
        }
    }
}

/**
 * Wrapper function for the CUDA kernel function.
 * @param A Array A.
 * @param B Array B.
 * @param C Sum of array elements A and B directly across.
 * @param arraySize Size of arrays A, B, and C.
 */


void kernel(double* A, double* B, double* C, int n) {

    double* a, * b, * c11;
    // Allocate device memory.
    cudaMalloc((void**)&a, n * n * sizeof(double));
    cudaMalloc((void**)&b, n * n * sizeof(double));
    cudaMalloc((void**)&c11, n * n * sizeof(double));

    // Transfer arrays a and b to device.
    cudaMemcpy(a, A, n * n * sizeof(double), cudaMemcpyHostToDevice);
    cudaMemcpy(b, B, n * n * sizeof(double), cudaMemcpyHostToDevice);


    int THREADS = 32;

    // Blocks per grid dimension (assumes THREADS divides N evenly)
    int BLOCKS = n / THREADS;

    // Use dim3 structs for block  and grid dimensions
    dim3 threads(THREADS, THREADS);
    dim3 blocks(BLOCKS, BLOCKS);


    vectorAdditionKernel << < 1024, 1024 >> > (a, b, c11, n);


    cudaDeviceSynchronize();

    cudaMemcpy(C, c11, n*n * sizeof(double), cudaMemcpyDeviceToHost);

}


