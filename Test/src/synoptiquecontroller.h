#ifndef SYNOPTIQUECONTROLLER_H
#define SYNOPTIQUECONTROLLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QEventLoop>
#include <QImage>
#include <QQuickImageProvider>
#include <QObject>

class SynoptiqueController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList composants READ composants CONSTANT)
    Q_PROPERTY(QStringList descriptions READ descriptions CONSTANT)
    Q_PROPERTY(QList<int> xs READ xs CONSTANT)
    Q_PROPERTY(QList<int> ys READ ys CONSTANT)
    Q_PROPERTY(QImage image READ image NOTIFY imageChanged)
    Q_PROPERTY(QString imageUrl READ imageUrl NOTIFY imageUrlChanged)

public:
    SynoptiqueController(QObject *parent = nullptr);

    QNetworkAccessManager manager;
    QJsonObject jsonObject;
    QByteArray postData;
    QNetworkReply *reply;
    QEventLoop loop;

    QStringList composants() const;
    QStringList descriptions() const;
    QList<int> xs() const;
    QList<int> ys() const;

    QImage image() const;

    QString imageUrl() const;

public slots:
    void addComposant(const QString &id,const QString &perimetre,const QString &system,const QString &name,const QString &description,const int &x,const int &y);
    void deleteComposant(const QString &id,const QString &perimetre,const QString &system,const QString &name);
    void getComposants(const QString &id,const QString &perimetre,const QString &system);
    void openFileExplorer(const QString &id,const QString &perimetre,const QString &system);
    void getImage(const QString &id,const QString &perimetre,const QString &system);
private:
    QStringList m_composants;
    QStringList m_descriptions;
    QList<int> m_xs;
    QList<int> m_ys;
    QImage m_image;
    QString m_imageUrl;

signals:
    void fileSelected(const QByteArray &fileData);
    void imageChanged();
    void imageUrlChanged();
};

#endif // SYNOPTIQUECONTROLLER_H
