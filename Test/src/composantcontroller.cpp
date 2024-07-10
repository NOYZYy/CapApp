#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QEventLoop>
#include "composantcontroller.h"

ComposantController::ComposantController(QObject *parent)
    : QObject{parent}
{
    //getComposants("664c6f584484f602636b34bd","ddd","string");
    //addComposant("664c6f584484f602636b34bd","ddd","string","test","test");
    //updateComposant("664c6f584484f602636b34bd","ddd","string","test","tist","tist");
    //deleteComposant("664c6f584484f602636b34bd","ddd","string","tist");
}

QStringList ComposantController::composants() const
{
    return m_composants;
}

QStringList ComposantController::descriptions() const
{
    return m_descriptions;
}

QString ComposantController::description() const
{
    return m_description;
}

void ComposantController::setDescription(const QString &newDescription)
{
    if (m_description == newDescription)
        return;
    m_description = newDescription;
    emit descriptionChanged();
}

QString ComposantController::composant() const
{
    return m_composant;
}

void ComposantController::setComposant(const QString &newComposant)
{
    if (m_composant == newComposant)
        return;
    m_composant = newComposant;
    emit composantChanged();
}

void ComposantController::getComposants(const QString &id, const QString &perimetre, const QString &system)
{
    QUrl urlapi("http://127.0.0.1:8000/composant/get");
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
        m_ids.clear();m_composants.clear();m_descriptions.clear();
        for(int i=0;i< jsonArray.size();i++){
            jsonObject = jsonArray.at(i).toObject();
            m_ids.append(id);
            m_composants.append(jsonObject["name"].toString()) ;
            m_descriptions.append(jsonObject["description"].toString()) ;
        }
        qDebug() << m_composants;
    }
    else{
        qDebug() << "error: "<< reply->errorString();
    }
}

void ComposantController::addComposant(const QString &id, const QString &perimetre, const QString &system, const QString &name, const QString &description)
{
    QUrl urlapi("http://127.0.0.1:8000/composant");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["name"]= name;
    jsonObject["description"]= description;
    jsonObject["system"]= system;
    jsonObject["detail"]= "";
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager.post(request,postData);

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

void ComposantController::updateComposant(const QString &id, const QString &perimetre, const QString &system, const QString &composant, const QString &name, const QString &description)
{
    QUrl urlapi("http://127.0.0.1:8000/composant");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["system"]= system;
    jsonObject["composant"]= composant;
    jsonObject["name"]= name;
    jsonObject["description"]= description;
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager.put(request,postData);

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

void ComposantController::deleteComposant(const QString &id, const QString &perimetre, const QString &system, const QString &composant)
{
    QUrl urlapi("http://127.0.0.1:8000/composant");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["system"]= system;
    jsonObject["composant"]= composant;
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

QStringList ComposantController::ids() const
{
    return m_ids;
}
