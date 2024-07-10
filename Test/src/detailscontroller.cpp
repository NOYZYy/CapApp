#include <QDesktopServices>
#include <QDir>
#include <QFileDialog>
#include <QFile>
#include <QByteArray>
#include <QJsonDocument>
#include "detailscontroller.h"

DetailsController::DetailsController(QObject *parent)
    : QObject{parent}
{

    //getPdfs("664c6f584484f602636b34bd","efef","vdvdv","CDCC");
}

void DetailsController::openFileExplorer(const QString &id, const QString &perimetre, const QString &system, const QString &composant, const QString &type)
{
    QUrl urlapi("http://127.0.0.1:8000/upload");
    QNetworkRequest request(urlapi);

    QString fileName = QFileDialog::getOpenFileName(nullptr, "Open File", QDir::homePath());
    if (!fileName.isEmpty()) {
        QFile file(fileName);
        if (file.open(QIODevice::ReadOnly)) {
            QByteArray fileData = file.readAll();
            file.close();
            QString base64Data = fileData.toBase64();
            emit fileSelected(fileData);
            jsonObject["id"]= id;
            jsonObject["perimetre"]= perimetre;
            jsonObject["system"]= system;
            jsonObject["composant"]= composant;
            jsonObject["type"]= type;
            jsonObject["base64"]= base64Data;
            postData = QJsonDocument(jsonObject).toJson();
            request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
            reply = manager.post(request,postData);

            QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
            loop.exec();

            if(reply->error() == QNetworkReply::NoError){
                if(type== "pdf2d"){
                    m_pdf2d= true;
                    QByteArray pdfData = QByteArray::fromBase64(base64Data.toUtf8());
                    QString localFilePath = QUrl("file:///C:/Users/NOYZz/Documents/pdf2d.pdf").toLocalFile();
                    qDebug() << "Local file path:" << localFilePath;
                    QFile pdfFile(localFilePath);
                    if (!pdfFile.open(QIODevice::WriteOnly)) {
                        qWarning() << "Failed to open file for writing:" << "C:/Users/NOYZz/Documents/pdf2d.pdf";
                    }
                    pdfFile.write(pdfData);
                    pdfFile.close();
                    emit pdfChanged(type);
                }
                if(type== "pdf3d"){
                    m_pdf3d= true;
                    QByteArray pdfData = QByteArray::fromBase64(base64Data.toUtf8());
                    QString localFilePath = QUrl("file:///C:/Users/NOYZz/Documents/pdf3d.pdf").toLocalFile();
                    QFile pdfFile(localFilePath);
                    if (!pdfFile.open(QIODevice::WriteOnly)) {
                        qWarning() << "Failed to open file for writing:" << "C:/Users/NOYZz/Documents/pdf3d.pdf";
                    }
                    pdfFile.write(pdfData);
                    pdfFile.close();
                    emit pdfChanged(type);
                }
                if(type== "regle"){
                    m_regle= true;
                    QByteArray pdfData = QByteArray::fromBase64(base64Data.toUtf8());
                    QString localFilePath = QUrl("file:///C:/Users/NOYZz/Documents/regle.pdf").toLocalFile();
                    QFile pdfFile(localFilePath);
                    if (!pdfFile.open(QIODevice::WriteOnly)) {
                        qWarning() << "Failed to open file for writing:" << "C:/Users/NOYZz/Documents/regle.pdf";
                    }
                    pdfFile.write(pdfData);
                    pdfFile.close();
                    emit pdfChanged(type);
                }
            }
        }
    }
}

void DetailsController::getPdfs(const QString &id, const QString &perimetre, const QString &system, const QString &composant)
{
    QUrl urlapi("http://127.0.0.1:8000/upload/get");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["system"]= system;
    jsonObject["composant"]= composant;
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager.post(request,postData);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();
    m_pdf2d = false;m_pdf3d = false;m_regle = false;
    if(reply->error() == QNetworkReply::NoError){
        QString jsonString = reply->readAll();
        QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonString.toUtf8());
        QJsonObject jsonObject = jsonDocument.object();
        if(jsonObject.contains("pdf2d")){
            m_pdf2d= true;
            QByteArray pdfData = QByteArray::fromBase64(jsonObject["conseption 2D"].toString().toUtf8());
            QString localFilePath = QUrl("file:///C:/Users/NOYZz/Documents/pdf2d.pdf").toLocalFile();
            qDebug() << "Local file path:" << localFilePath;
            QFile pdfFile(localFilePath);
            if (!pdfFile.open(QIODevice::WriteOnly)) {
                qWarning() << "Failed to open file for writing:" << "C:/Users/NOYZz/Documents/pdf2d.pdf";
            }
            pdfFile.write(pdfData);
            pdfFile.close();
        }
        if(jsonObject.contains("pdf3d")){
            m_pdf3d= true;
            QByteArray pdfData = QByteArray::fromBase64(jsonObject["pdf3d"].toString().toUtf8());
            QString localFilePath = QUrl("file:///C:/Users/NOYZz/Documents/pdf3d.pdf").toLocalFile();
            QFile pdfFile(localFilePath);
            if (!pdfFile.open(QIODevice::WriteOnly)) {
                qWarning() << "Failed to open file for writing:" << "C:/Users/NOYZz/Documents/pdf3d.pdf";
            }
            pdfFile.write(pdfData);
            pdfFile.close();
        }
        if(jsonObject.contains("regle")){
            m_regle= true;
            QByteArray pdfData = QByteArray::fromBase64(jsonObject["regle"].toString().toUtf8());
            QString localFilePath = QUrl("file:///C:/Users/NOYZz/Documents/regle.pdf").toLocalFile();
            QFile pdfFile(localFilePath);
            if (!pdfFile.open(QIODevice::WriteOnly)) {
                qWarning() << "Failed to open file for writing:" << "C:/Users/NOYZz/Documents/regle.pdf";
            }
            pdfFile.write(pdfData);
            pdfFile.close();
        }
    }
}

void DetailsController::openPdf(const QString filePath)
{
    QDesktopServices::openUrl(QUrl(filePath));
}

bool DetailsController::pdf2d() const
{
    return m_pdf2d;
}

void DetailsController::setPdf2d(bool newPdf2d)
{
    if (m_pdf2d == newPdf2d)
        return;
    m_pdf2d = newPdf2d;
    emit pdf2dChanged();
}

bool DetailsController::pdf3d() const
{
    return m_pdf3d;
}

void DetailsController::setPdf3d(bool newPdf3d)
{
    if (m_pdf3d == newPdf3d)
        return;
    m_pdf3d = newPdf3d;
    emit pdf3dChanged();
}

bool DetailsController::regle() const
{
    return m_regle;
}

void DetailsController::setRegle(bool newRegle)
{
    if (m_regle == newRegle)
        return;
    m_regle = newRegle;
    emit regleChanged();
}
