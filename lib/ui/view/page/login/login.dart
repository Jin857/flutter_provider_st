import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/core/config/assets_config.dart';
import 'package:flutter_provider_st/core/http/http_factory.dart';
import 'package:flutter_provider_st/models/user.dart';
import 'package:flutter_provider_st/provider/user_model.dart';
import 'package:flutter_provider_st/ui/component/image/l_image.dart';
import 'package:flutter_provider_st/ui/component/toast/toast_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue[100],
          height: ScreenUtil().screenHeight,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LImage(
                        image: AssetsConfig.lobbymain,
                        width: 120.w,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(100),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().setSp(20)),
                      topRight: Radius.circular(ScreenUtil().setSp(20)),
                    ),
                  ),
                  height: 30.0,
                  child: const LoginRoute(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _unameController = TextEditingController();

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
                controller: _unameController,
                decoration: const InputDecoration(
                  labelText: "登陆密钥",
                  hintText: "登陆密钥",
                  prefixIcon: Icon(Icons.phone_android_rounded),
                ),
                // 校验手机号（不能为空）
                validator: (v) {
                  return v == null || v.trim().isNotEmpty ? null : "请输入登陆密钥";
                }),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(25)),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(
                  height: ScreenUtil().setHeight(40),
                ),
                child: ElevatedButton(
                  onPressed: _onLogin,
                  child: Text(
                    "登 陆",
                    style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLogin() async {
    // 先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      User? user;
      try {
        user = await HttpFactory.instance().user.login(_unameController.text);
        if (!mounted) return; // 如果 Widget 不再挂载，则直接退出，不执行后续操作
        // 因为登录页返回后，首页会build，所以我们传入false，这样更新user后便不触发更新。
        Provider.of<UserModel>(context, listen: false).user = user;
      } on DioException catch (e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {
          // ToastUtils.show(GmLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          ToastUtils.show(name: e.toString());
        }
      } finally {
        // 隐藏loading框
        // Navigator.of(context).pop();
      }

      /// 登录成功则返回
      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
