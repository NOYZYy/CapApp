#include "systemcontroller.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QEventLoop>

SystemController::SystemController(QObject *parent)
    : QObject{parent}
{
    //getSystems("664c6f584484f602636b34bd","ddd");
    //addSystem("664c6f584484f602636b34bd","cdc","test","test");
    //updateSystem("664c6f584484f602636b34bd","ddd","cddc","test","test");
    //deleteSystem("664c6f584484f602636b34bd","ddd","nnnn");
}

QStringList SystemController::systems() const
{
    return m_systems;
}

QStringList SystemController::descriptions() const
{
    return m_descriptions;
}

QString SystemController::system() const
{
    return m_system;
}

void SystemController::setSystem(const QString &newSystem)
{
    if (m_system == newSystem)
        return;
    m_system = newSystem;
    emit systemChanged();
}

QString SystemController::description() const
{
    return m_description;
}

void SystemController::setDescription(const QString &newDescription)
{
    if (m_description == newDescription)
        return;
    m_description = newDescription;
    emit descriptionChanged();
}

void SystemController::getSystems(const QString &id, const QString &perimetre)
{
    QUrl urlapi("http://127.0.0.1:8000/system/get");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
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
        m_ids.clear();m_systems.clear();m_descriptions.clear();
        for(int i=0;i< jsonArray.size();i++){
            jsonObject = jsonArray.at(i).toObject();
            m_ids.append(id);
            m_systems.append(jsonObject["name"].toString()) ;
            m_descriptions.append(jsonObject["description"].toString()) ;
        }
    }
    else{
        qDebug() << "error: "<< reply->errorString();
    }
}

void SystemController::addSystem(const QString &id, const QString &perimetre, const QString &name, const QString &description)
{
    QUrl urlapi("http://127.0.0.1:8000/system");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["name"]= name;
    jsonObject["description"]= description;
    jsonObject["composants"]= "";
    jsonObject["synoptique"]= "";
    jsonObject["nftrs"]= "";
    jsonObject["quiz"]= "";
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

void SystemController::updateSystem(const QString &id, const QString &perimetre, const QString &system, const QString &name, const QString &description)
{
    QUrl urlapi("http://127.0.0.1:8000/system");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["system"]= system;
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

void SystemController::deleteSystem(const QString &id, const QString &perimetre, const QString &system)
{
    QUrl urlapi("http://127.0.0.1:8000/system");
    QNetworkRequest request(urlapi);

    jsonObject["id"]= id;
    jsonObject["perimetre"]= perimetre;
    jsonObject["system"]= system;
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

QStringList SystemController::ids() const
{
    return m_ids;
}
