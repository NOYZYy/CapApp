#ifndef DETAILSCONTROLLER_H
#define DETAILSCONTROLLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QEventLoop>
#include <QObject>

class DetailsController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool pdf2d READ pdf2d WRITE setPdf2d NOTIFY pdf2dChanged FINAL)
    Q_PROPERTY(bool pdf3d READ pdf3d WRITE setPdf3d NOTIFY pdf3dChanged FINAL)
    Q_PROPERTY(bool regle READ regle WRITE setRegle NOTIFY regleChanged FINAL)
public:
    explicit DetailsController(QObject *parent = nullptr);

    QNetworkAccessManager manager;
    QJsonObject jsonObject;
    QByteArray postData;
    QNetworkReply *reply;
    QEventLoop loop;

    bool pdf2d() const;
    void setPdf2d(bool newPdf2d);

    bool pdf3d() const;
    void setPdf3d(bool newPdf3d);

    bool regle() const;
    void setRegle(bool newRegle);

public slots:
    void openFileExplorer(const QString &id, const QString &perimetre, const QString &system, const QString &composant, const QString &type);
    void getPdfs(const QString &id, const QString &perimetre, const QString &system, const QString &composant);
    void openPdf(const QString filePath);

signals:
    void fileSelected(const QByteArray &fileData);
    void pdf2dChanged();
    void pdf3dChanged();
    void pdfChanged(const QString &file);
    void regleChanged();

private:
    bool m_pdf2d;
    bool m_pdf3d;
    bool m_regle;
};

#endif // DETAILSCONTROLLER_H
