#ifndef QUIZCONTROLLER_H
#define QUIZCONTROLLER_H

#include "qtmetamacros.h"
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QEventLoop>
#include <QObject>
#include <QFile>

class QuizController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList questions READ questions CONSTANT)
    Q_PROPERTY(QList<QStringList> answers READ answers CONSTANT)
    Q_PROPERTY(QStringList rightAnswers READ rightAnswer CONSTANT)
    Q_PROPERTY(QString fileName READ fileName WRITE setFileName NOTIFY fileNameChanged FINAL)
    Q_PROPERTY(QString fileInformation READ fileInformation WRITE setFileInformation NOTIFY fileInformationChanged FINAL)
public:
    explicit QuizController(QObject *parent = nullptr);

    QNetworkAccessManager manager;
    QJsonObject jsonObject;
    QByteArray postData;
    QFile csvFile;
    QNetworkReply *reply;
    QEventLoop loop;

    QStringList questions() const;

    QList<QStringList> answers() const;

    QStringList rightAnswer() const;

    QString fileName() const;
    void setFileName(const QString &newFileName);

    QString fileInformation() const;
    void setFileInformation(const QString &newFileInformation);

public slots:
    void getQuiz(const QString &id, const QString &perimetre, const QString &system);
    void openFileExplorer();
    void uploadCsv(const QString &id, const QString &perimetre, const QString &system);
signals:

    void fileNameChanged();

    void fileInformationChanged();

private:
    QStringList m_questions;
    QList<QStringList> m_answers;
    QStringList m_rightAnswers;
    QString m_fileName;
    QString m_fileInformation;
};

#endif // QUIZCONTROLLER_H
