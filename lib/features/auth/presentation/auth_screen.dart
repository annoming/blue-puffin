import 'package:flutter/material.dart';
import '../data/auth_repository.dart';
import '../../user/presentation/user_profile_edit_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authRepository = AuthRepository();
  bool _isLoading = false;
  bool _isRegistering = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final identifier = _identifierController.text.trim();
      if (_isRegistering) {
        dynamic user;
        if (identifier.contains('@')) {
          user = await _authRepository.registerWithEmail(identifier, _passwordController.text);
        } else {
          user = await _authRepository.registerWithPhone(identifier, _passwordController.text);
        }
        if (mounted && user != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('注册成功（本地账号，无后端）')));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => UserProfileEditScreen(userId: user.id)),
          );
        }
      } else {
        final user = await _authRepository.login(identifier, _passwordController.text);
        if (mounted && user != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('登录成功（本地模式）')));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => UserProfileEditScreen(userId: user.id)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('操作失败: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isRegistering ? '注册' : '登录')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '本地账号（无后端）',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('所有数据存储在本地 Isar 数据库中'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _identifierController,
                decoration: const InputDecoration(labelText: '手机号或邮箱', border: OutlineInputBorder()),
                validator: (v) {
                  if (v == null || v.isEmpty) return '请输入手机号或邮箱';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: '密码', border: OutlineInputBorder()),
                obscureText: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return '请输入密码';
                  if (v.length < 6) return '密码至少6位';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading ? const CircularProgressIndicator() : Text(_isRegistering ? '注册' : '登录'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => setState(() => _isRegistering = !_isRegistering),
                child: Text(_isRegistering ? '已有账号？立即登录' : '还没有账号？立即注册'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
