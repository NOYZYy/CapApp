#ifndef SYSTEMCONTROLLER_H
#define SYSTEMCONTROLLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QEventLoop>
#include <QObject>

class SystemController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList ids READ ids CONSTANT)
    Q_PROPERTY(QStringList systems READ systems CONSTANT)
    Q_PROPERTY(QStringList descriptions READ descriptions CONSTANT)
    Q_PROPERTY(QString system READ system WRITE setSystem NOTIFY systemChanged FINAL)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged FINAL)
public:
    explicit SystemController(QObject *parent = nullptr);

    QStringList systems() const;

    QStringList descriptions() const;

    QString system() const;
    void setSystem(const QString &newSystem);

    QString description() const;
    void setDescription(const QString &newDescription);

    QNetworkAccessManager manager;
    QJsonObject jsonObject;
    QByteArray postData;
    QNetworkReply *reply;
    QEventLoop loop;


    QStringList ids() const;

signals:
    void systemChanged();
    void descriptionChanged();

public slots:
    void getSystems(const QString &id,const QString &perimetre);
    void addSystem(const QString &id,const QString &perimetre,const QString &name,const QString &description);
    void updateSystem(const QString &id,const QString &perimetre,const QString &system,const QString &name,const QString &description);
    void deleteSystem(const QString &id,const QString &perimetre,const QString &system);


private:
    QStringList m_systems;
    QStringList m_descriptions;
    QString m_system;
    QString m_description;
    QStringList m_ids;
};

#endif // SYSTEMCONTROLLER_H
