#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QEventLoop>
#include "perimetrecontroller.h"


PerimetreController::PerimetreController(QObject *parent)
    : QObject{parent}
{}

QStringList PerimetreController::perimetres() const
{
    return m_perimetres;
}

QStringList PerimetreController::descriptions() const
{
    return m_descriptions;
}

QString PerimetreController::perimetre() const
{
    return m_perimetre;
}

void PerimetreController::setPerimetre(const QString &newPerimetre)
{
    if (m_perimetre == newPerimetre)
        return;
    m_perimetre = newPerimetre;
    emit perimetreChanged();
}

QString PerimetreController::description() const
{
    return m_description;
}

void PerimetreController::setDescription(const QString &newDescription)
{
    if (m_description == newDescription)
        return;
    m_description = newDescription;
    emit descriptionChanged();
}

void PerimetreController::parsedata()
{
    QUrl urlapi("http://127.0.0.1:8000");
    QNetworkRequest request(urlapi);

    jsonObject["name"]= m_perimetre;
    jsonObject["description"]= m_description;
    jsonObject["systems"]= "";
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    qDebug() << postData;
    reply = manager.post(request,postData);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();

    if(reply->error() == QNetworkReply::NoError){
        QString jsonString = reply->readAll();
        QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonString.toUtf8());
        QJsonObject jsonObject = jsonDocument.object();
        m_id= jsonObject["id"].toString();
        // m_ids.append(m_id);m_perimetres.append(m_perimetre);m_descriptions.append(m_descriptions);
    }
    else{
        qDebug() << "error: "<< reply->errorString();
    }
}

void PerimetreController::deletedata(const QString &collection)
{
    QUrl urlapi("http://127.0.0.1:8000");
    QNetworkRequest request(urlapi);

    jsonObject["collection"]= collection;
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager.sendCustomRequest(request,"DELETE",postData);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();
}

void PerimetreController::modifydata(const QString &collection,const QString &id, const QString &name, const QString &descreption)
{
    QUrl urlapi("http://127.0.0.1:8000");
    QNetworkRequest request(urlapi);

    jsonObject["collection"]= collection;
    jsonObject["description"]= descreption;
    jsonObject["name"]= name;
    jsonObject["id"]= id;
    postData = QJsonDocument(jsonObject).toJson();
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    qDebug() << "error: "<< postData;
    reply = manager.put(request,postData);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();
}

QStringList PerimetreController::ids() const
{
    return m_ids;
}

void PerimetreController::setId(const QString &newId)
{
    if (m_id == newId)
        return;
    m_id = newId;
    emit idChanged();
}

void PerimetreController::getPerimetres()
{
    QUrl urlapi("http://127.0.0.1:8000");
    QNetworkRequest request(urlapi);
    reply = manager.get(request);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();

    if(reply->error() == QNetworkReply::NoError){
        QString jsonString = reply->readAll();
        QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonString.toUtf8());
        QJsonArray jsonArray = jsonDocument.array();
        QJsonObject jsonObject;
        m_ids.clear();m_perimetres.clear();m_descriptions.clear();
        for(int i=0;i< jsonArray.size();i++){
            jsonObject = jsonArray.at(i).toArray().at(0).toObject();
            m_ids.append(jsonObject["id"].toString());
            m_perimetres.append(jsonObject["name"].toString()) ;
            m_descriptions.append(jsonObject["description"].toString()) ;
        }
    }
    else{
        qDebug() << "error: "<< reply->errorString();
    }
}

QString PerimetreController::id() const
{
    return m_id;
}
