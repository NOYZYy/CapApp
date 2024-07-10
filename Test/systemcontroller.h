#ifndef SYSTEMCONTROLLER_H
#define SYSTEMCONTROLLER_H

#include <QObject>

class SystemController : public QObject
{
    Q_OBJECT
public:
    explicit SystemController(QObject *parent = nullptr);

signals:
};

#endif // SYSTEMCONTROLLER_H
