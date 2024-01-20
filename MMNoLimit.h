#ifndef MMNOLIMIT_H
#define MMNOLIMIT_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QDebug>
#include <QTimer>
#include <QVariant>
#include <QQuickWindow>
#include <fstream>
#include <sstream>
#include <QDate>
#include <QTime>
#include <iostream>
#include <cmath>

class MMNoLimit : public QObject
{
    Q_OBJECT
public:
    explicit MMNoLimit(QObject *parent = nullptr);

    void* addVectorsCPU(double* a, double* b, int n);
    double* genRanVec(int n);

private:
    int sizeOfMatrice=100;
    double valueOfMatrices=1;
    int min=0;
    int max=256;
    double* b;

signals:
    void setGreenCPU();
    void setGreenGPU();

    void textConsolelog(QVariant);
    void textConsolelog2(QVariant);


    void timeGPU(QVariant);
    void timeCPU(QVariant);

    void sendResults(QVariant);


public slots:
    void functionCuda();
    void functionNoCuda();
    void setSizeMatrices(QVariant size);
    void seteMatricesValue(QVariant value);
    void minMaxSendTo(QVariant value,QVariant obj);
    void startShowResult();

private slots:

};

#endif // MMNOLIMIT_H
