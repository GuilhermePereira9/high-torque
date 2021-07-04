import 'package:flutter/material.dart';
import 'package:virtual_store/helpers/validators.dart';
import 'package:virtual_store/models/user.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/user_manager.dart';

class SingUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final User user = User();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Nome Completo'),
                        enabled: !userManager.loading,
                        validator: (name) {
                          if (name.isEmpty)
                            return 'Campo obrigatorio';
                          else if (name.trim().split(' ').length <= 1)
                            return 'Preencha seu nome completo';
                          return null;
                        },
                        onSaved: (name) => user.name = name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        enabled: !userManager.loading,
                        validator: (email) {
                          if (email.isEmpty)
                            return 'Campo Invalido';
                          else if (!emailValid(email)) return 'Email invalido';
                          return null;
                        },
                        onSaved: (email) => user.email = email,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(hintText: 'Senha'),
                        obscureText: true,
                        enabled: !userManager.loading,
                        validator: (pass) {
                          if (pass.isEmpty)
                            return 'Campo obrigatorio';
                          else if (pass.length < 6) return 'Senha muito curta';
                          return null;
                        },
                        onSaved: (pass) => user.password = pass,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Repita a senha'),
                        enabled: !userManager.loading,
                        obscureText: true,
                        validator: (pass) {
                          if (pass.isEmpty)
                            return 'Campo obrigatorio';
                          else if (pass.length < 6) return 'Senha muito curta';
                          return null;
                        },
                        onSaved: (pass) => user.confirmPassword = pass,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              onSurface: Theme.of(context)
                                  .primaryColor
                                  .withAlpha(100)),
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();

                                    if (user.password != user.confirmPassword) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Senhas não coincidem!'),
                                        backgroundColor: Colors.red,
                                      ));
                                      return;
                                    }

                                    userManager.signUp(
                                        user: user,
                                        onSucess: () {
                                          Navigator.of(context).pop();
                                        },
                                        onFail: (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Falha ao Cadastrar: $e'),
                                            backgroundColor: Colors.red,
                                          ));
                                        });
                                  }
                                  ;
                                },
                          child: userManager.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  'Criar Conta',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
