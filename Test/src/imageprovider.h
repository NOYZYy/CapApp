#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QObject>
#include <QImage>
#include <QQuickImageProvider>

class ImageProvider : public QObject {
    Q_OBJECT
public:
    explicit ImageProvider(QObject *parent = nullptr);

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);

public slots:
    void setBase64Image(const QString &base64);

private:
    QImage m_image;
};

#endif // IMAGEPROVIDER_H
