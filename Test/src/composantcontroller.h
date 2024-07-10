#ifndef COMPOSANTCONTROLLER_H
#define COMPOSANTCONTROLLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QEventLoop>
#include <QObject>

class ComposantController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList ids READ ids CONSTANT)
    Q_PROPERTY(QStringList composants READ composants CONSTANT)
    Q_PROPERTY(QStringList descriptions READ descriptions CONSTANT)
    Q_PROPERTY(QString composant READ composant WRITE setComposant NOTIFY composantChanged FINAL)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged FINAL)
public:
    explicit ComposantController(QObject *parent = nullptr);
    QStringList composants() const;
    QStringList descriptions() const;
    QString description() const;
    void setDescription(const QString &newDescription);
    QString composant() const;
    void setComposant(const QString &newComposant);

    QNetworkAccessManager manager;
    QJsonObject jsonObject;
    QByteArray postData;
    QNetworkReply *reply;
    QEventLoop loop;

    QStringList ids() const;

public slots:
    void getComposants(const QString &id,const QString &perimetre,const QString &system);
    void addComposant(const QString &id,const QString &perimetre,const QString &system,const QString &name,const QString &description);
    void updateComposant(const QString &id,const QString &perimetre,const QString &system,const QString &composant,const QString &name,const QString &description);
    void deleteComposant(const QString &id,const QString &perimetre,const QString &system,const QString &composant);
signals:
    void composantChanged();
    void descriptionChanged();

private:
    QStringList m_composants;
    QStringList m_descriptions;
    QString m_description;
    QString m_composant;
    QStringList m_ids;
};

#endif // COMPOSANTCONTROLLER_H
