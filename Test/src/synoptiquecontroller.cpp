#include "synoptiquecontroller.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QFileInfo>
#include <QDebug>
#include <QDesktopServices>
#include <QDir>
#include <QFileDialog>
#include <QByteArray>
#include <QFile>
#include <QBuffer>
#include <QStandardPaths>

SynoptiqueController::SynoptiqueController(QObject *parent)
    : QObject{parent}{
    // addComposant("6664c6593be68ed6e697fc57","TRM","CPCC", "name2","description",12,12);
    // getComposants("6664c6593be68ed6e697fc57","TRM","CPCC");
    // deleteComposant("6664c6593be68ed6e697fc57","TRM","CPCC","name1");
    // getImage("6664c6593be68ed6e697fc57","TRM","CPCC");
}

void SynoptiqueController::addComposant(const QString &id, const QString &perimetre, const QString &system, const QString &name, const QString &description, const int &x, const int &y)
{
    QUrl urlapi("http://127.0.0.1:8000/synoptique");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["composant"]= name;
    jsonObject["description"]= description;
    jsonObject["system"]= system;
    jsonObject["x"]= x;
    jsonObject["y"]= y;
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager.put(request,postData);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();
    if(reply->error() == QNetworkReply::NoError){
        QString jsonString = reply->readAll();
        qDebug() << "no error: "<< jsonString;
    }
    else{
        qDebug() << "error: "<< reply->errorString();
    }
}

void SynoptiqueController::deleteComposant(const QString &id, const QString &perimetre, const QString &system, const QString &name)
{
    QUrl urlapi("http://127.0.0.1:8000/synoptique");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["system"]= system;
    jsonObject["composant"]= name;
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager.sendCustomRequest(request,"DELETE",postData);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();
    if(reply->error() == QNetworkReply::NoError){
        QString jsonString = reply->readAll();
        qDebug() << jsonString;
    }
    else{
        qDebug() << "error: "<< reply->errorString();
    }
}

void SynoptiqueController::getComposants(const QString &id, const QString &perimetre, const QString &system)
{
    QUrl urlapi("http://127.0.0.1:8000/synoptique");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["system"]= system;
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager.post(request,postData);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();

    if(reply->error() == QNetworkReply::NoError){
        QString jsonString = reply->readAll();
        QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonString.toUtf8());
        QJsonArray jsonArray = jsonDocument.array();
        QJsonObject jsonObject;
        m_xs.clear();m_composants.clear();m_descriptions.clear();m_ys.clear();
        for(int i=0;i< jsonArray.size();i++){
            jsonObject = jsonArray.at(i).toObject();
            m_xs.append(jsonObject["x"].toInt());
            m_ys.append(jsonObject["y"].toInt());
            m_composants.append(jsonObject["name"].toString()) ;
            m_descriptions.append(jsonObject["description"].toString()) ;
        }
    }
}

void SynoptiqueController::openFileExplorer(const QString &id, const QString &perimetre, const QString &system)
{
    QUrl urlapi("http://127.0.0.1:8000/synoptique/image");
    QNetworkRequest request(urlapi);

    QString fileName = QFileDialog::getOpenFileName(nullptr, "Open File", QDir::homePath());
    QFileInfo fileInfo(fileName);
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
            jsonObject["image"]= fileInfo.fileName();
            jsonObject["base64"]= base64Data;
            postData = QJsonDocument(jsonObject).toJson();
            request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
            reply = manager.post(request,postData);

            QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
            loop.exec();

            if(reply->error() == QNetworkReply::NoError){
                getImage(id,perimetre,system);
            }
        }
    }
}

void SynoptiqueController::getImage(const QString &id, const QString &perimetre, const QString &system)
{
    QUrl urlapi("http://127.0.0.1:8000/synoptique/get/image");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["system"]= system;
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager.post(request,postData);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();
    if(reply->error() == QNetworkReply::NoError){
        QString jsonString = reply->readAll();
        QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonString.toUtf8());
        QByteArray byteArray = QByteArray::fromBase64(jsonDocument["base64"].toString().toUtf8());
        if (m_image.loadFromData(byteArray)) {
            QString tempDir = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
            QString tempFile = tempDir + "/"+jsonDocument["name"].toString(); // or .jpg depending on the image format
            if (m_image.save(tempFile)) {
                m_imageUrl = "file:///" + tempFile;
                emit imageUrlChanged();
            }
        }
        emit imageChanged();
    }
}

    QStringList SynoptiqueController::composants() const
    {
        return m_composants;
    }

    QStringList SynoptiqueController::descriptions() const
    {
        return m_descriptions;
    }

    QList<int> SynoptiqueController::xs() const
    {
        return m_xs;
    }

    QList<int> SynoptiqueController::ys() const
    {
        return m_ys;
    }

    QImage SynoptiqueController::image() const
    {
        return m_image;
    }

    QString SynoptiqueController::imageUrl() const
    {
        return m_imageUrl;
    }
