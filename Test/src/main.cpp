#include "src/detailscontroller.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQmlContext>
#include <QApplication>

#include "detailscontroller.h"
#include "composantcontroller.h"
#include "systemcontroller.h"
#include "perimetrecontroller.h"
#include "synoptiquecontroller.h"
#include "quizcontroller.h"
#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"

int main(int argc, char *argv[])
{
    set_qt_environment();
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    PerimetreController *perController= new PerimetreController(&app);
    SystemController *sysController= new SystemController(&app);
    ComposantController *compController= new ComposantController(&app);
    DetailsController *detController= new DetailsController(&app);
    SynoptiqueController *synController= new SynoptiqueController(&app);
    QuizController *quizController= new QuizController(&app);
    engine.rootContext()->setContextProperty("perController",perController);
    engine.rootContext()->setContextProperty("sysController",sysController);
    engine.rootContext()->setContextProperty("compController",compController);
    engine.rootContext()->setContextProperty("detController", detController);
    engine.rootContext()->setContextProperty("synController", synController);
    engine.rootContext()->setContextProperty("quizController", quizController);


    const QUrl url(u"qrc:/qt/qml/Main/main.qml"_qs);
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection);


    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    engine.load(url);
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    return app.exec();
}
