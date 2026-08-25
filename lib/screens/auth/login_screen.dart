  void _login() async {
    setState(() => _isLoading = true);
    String res = await AuthService().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() => _isLoading = false);

    if (res == "success" && mounted) {
      // সফলভাবে লগইন হলে MainScreen-এ পাঠিয়ে দেওয়া
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
    }
  }
