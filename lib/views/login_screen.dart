import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hipal/providers/login_provider.dart';
import 'package:hipal/providers/auth_provider.dart';
import 'package:hipal/viewmodels/login/login_view_model_impl.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final viewmodel = LoginViewModelImpl(loginProvider, authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hipal App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LoginForm(viewmodel: viewmodel),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final LoginViewModelImpl viewmodel;

  const LoginForm({Key? key, required this.viewmodel}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            onChanged: (value) {
              widget.viewmodel.updateEmail(value);
            },
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            validator: (_) => widget.viewmodel.emailError.isNotEmpty
                ? widget.viewmodel.emailError
                : null,
            decoration: const InputDecoration(
              labelText: 'Correo Electrónico',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            onChanged: (value) {
              widget.viewmodel.updatePassword(value);
            },
            obscureText: true,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            validator: (_) => widget.viewmodel.passwordError.isNotEmpty
                ? widget.viewmodel.passwordError
                : null,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool loginSuccess = await widget.viewmodel.performLogin(context);
                if (loginSuccess) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              }
            },
            child: const Text('Iniciar Sesión'),
          ),
          Consumer<LoginProvider>(
            builder: (context, loginProvider, _) {
              return Text(
                loginProvider.error,
                style: const TextStyle(color: Colors.red),
              );
            },
          ),
        ],
      ),
    );
  }
}
