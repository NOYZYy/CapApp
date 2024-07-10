#ifndef PERIMETRECONTROLLER_H
#define PERIMETRECONTROLLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QEventLoop>
#include <QObject>

class PerimetreController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList ids READ ids CONSTANT)
    Q_PROPERTY(QStringList perimetres READ perimetres CONSTANT)
    Q_PROPERTY(QStringList descriptions READ descriptions CONSTANT)
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString perimetre READ perimetre WRITE setPerimetre NOTIFY perimetreChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)

public:
    explicit PerimetreController(QObject *parent = nullptr);
    QStringList perimetres() const;
    QStringList descriptions() const;
    QString perimetre() const;
    void setPerimetre(const QString &newPerimetre);
    QString description() const;
    void setDescription(const QString &newDescription);
    QStringList ids() const;
    QString id() const;
    void setId(const QString &newId);

    QNetworkAccessManager manager;
    QJsonObject jsonObject;
    QByteArray postData;
    QNetworkReply *reply;
    QEventLoop loop;

signals:
    void perimetreChanged();
    void descriptionChanged();
    void idChanged();

public slots:
    void getPerimetres();
    void parsedata();
    void deletedata(const QString &collection);
    void modifydata(const QString &collection,const QString &id,const QString &name,const QString &descreption);
private:
    QStringList m_perimetres;
    QStringList m_descriptions;
    QString m_perimetre;
    QString m_description;
    QStringList m_ids;
    QString m_id;
};

#endif // PERIMETRECONTROLLER_H
