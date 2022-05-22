#include "logindialog.h"

#include <regex>
#include <QMessageBox>
#include <QMetaObject>

#include "cim/cim.h"
#include "server_setting_dialog.h"
#include "ui_logindialog.h"
#include "user_register_dialog.h"

LoginDialog::LoginDialog(QWidget* parent) : QDialog(parent), ui(new Ui::LoginDialog) {
    ui->setupUi(this);
    ui->labError->setVisible(false);
}

LoginDialog::~LoginDialog() {
    delete ui;
}

void LoginDialog::on_pushButton_clicked() {
    std::string userName = ui->leUserName->text().toStdString();
    std::regex regx("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$");
    bool ret = std::regex_match(userName.c_str(), regx);
    if (!ret) {
        QMessageBox::information(this, "Tips", "邮箱格式不正确", QMessageBox::Yes);
        return;
    }

    if (ui->lePwd->text().length() <= 3) {
        QMessageBox::information(this, "Tips", "请输入至少3位密码", QMessageBox::Yes);
        return;
    }

    std::string user_name = ui->leUserName->text().toStdString();
    std::string pwd = ui->lePwd->text().toStdString();

    auto cb1 = std::bind(&LoginDialog::onLoginResult, this, std::placeholders::_1);
    auto cb2 = std::bind(&LoginDialog::onLoginTimeout, this);
    cim::core::Client::getInstance()->login(user_name, pwd, cb1, cb2);
}

void LoginDialog::on_pushButton_2_clicked() {
    ServerSettingDialog dialog;
    dialog.exec();
}

void LoginDialog::onLoginResult(const CIM::Login::CIMAuthRsp& rsp) {
    QMetaObject::invokeMethod(this, [=]() {
        if (rsp.result_code() == CIM::Def::CIMErrorCode::kCIM_ERR_SUCCESS) {
            this->accept();
        } else {
            QMessageBox::information(this, "Tips", QString::fromStdString(rsp.result_string()), QMessageBox::Yes);
        }
    });
}

void LoginDialog::onLoginTimeout() {
    QMetaObject::invokeMethod(
        this, [=] { QMessageBox::information(this, "Tips", "登录超时，服务器无响应", QMessageBox::Yes); });
}

void LoginDialog::on_pushButton_3_clicked() {
    UserRegisterDialog dialog;
    dialog.exec();
}
