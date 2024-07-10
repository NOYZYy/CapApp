#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QFileDialog>
#include "quizcontroller.h"

QuizController::QuizController(QObject *parent)
    : QObject{parent}
{
    //getQuiz("6664c6593be68ed6e697fc57","TRM","CPAI");
}

void QuizController::getQuiz(const QString &id, const QString &perimetre, const QString &system)
{
    QUrl urlapi("http://127.0.0.1:8000/csv");
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
        QStringList slist;
        m_questions.clear();m_answers.clear();m_rightAnswers.clear();
        for(int i=0;i< jsonArray.size();i++){
            slist.clear();
            jsonObject = jsonArray.at(i).toObject();
            m_questions.append(jsonObject["Question"].toString());
            slist.append(jsonObject["A"].toString());slist.append(jsonObject["B"].toString());
            slist.append(jsonObject["C"].toString());slist.append(jsonObject["D"].toString());
            m_answers.append(slist);
            m_rightAnswers.append(jsonObject["Answer"].toString());
        }
    }
}

void QuizController::openFileExplorer()
{
    QString fileName = QFileDialog::getOpenFileName(nullptr, "Open File", QDir::homePath(), "CSV Files (*.csv)");
    if (!fileName.isEmpty()) {
        QFileInfo fileInfo(fileName);
        m_fileName= fileName;
        emit fileNameChanged();
        m_fileInformation= fileInfo.fileName();
    }
}

void QuizController::uploadCsv(const QString &id, const QString &perimetre, const QString &system)
{
    QUrl urlapi("http://127.0.0.1:8000/csv");
    QNetworkRequest request(urlapi);

    if (!m_fileName.isEmpty()) {
        QFile file(m_fileName);
        if (file.open(QIODevice::ReadOnly)) {
            QByteArray fileData = file.readAll();
            file.close();
            QString base64Data = fileData.toBase64();
            jsonObject["id"]= id;
            jsonObject["perimetre"]= perimetre;
            jsonObject["system"]= system;
            jsonObject["base64"]= base64Data;
            postData = QJsonDocument(jsonObject).toJson();
            request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
            reply = manager.put(request,postData);

            QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
            loop.exec();

            if(reply->error() == QNetworkReply::NoError){

            }
        }
    }
}

QStringList QuizController::questions() const
{
    return m_questions;
}

QList<QStringList> QuizController::answers() const
{
    return m_answers;
}

QStringList QuizController::rightAnswer() const
{
    return m_rightAnswers;
}

QString QuizController::fileName() const
{
    return m_fileName;
}

void QuizController::setFileName(const QString &newFileName)
{
    if (m_fileName == newFileName)
        return;
    m_fileName = newFileName;
    emit fileNameChanged();
}

QString QuizController::fileInformation() const
{
    return m_fileInformation;
}

void QuizController::setFileInformation(const QString &newFileInformation)
{
    if (m_fileInformation == newFileInformation)
        return;
    m_fileInformation = newFileInformation;
    emit fileInformationChanged();
}
