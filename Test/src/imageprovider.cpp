#include "imageprovider.h"
#include <QImage>
#include <QByteArray>
#include <QBuffer>
#include <QDebug>

ImageProvider::ImageProvider(QObject *parent)
    : QObject(parent), QQuickImageProvider(QQuickImageProvider::Image) {
}

void ImageProvider::setBase64Image(const QString &base64) {
    QByteArray byteArray = QByteArray::fromBase64(base64.toUtf8());
    m_image.loadFromData(byteArray);
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize) {
    if (size) *size = m_image.size();
    return m_image;
}
