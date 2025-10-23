import 'package:flutter/material.dart';
import 'products_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Navegar a la pantalla de productos
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener información de la pantalla usando MediaQuery
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    // Determinar el tipo de dispositivo basado en el ancho
    // Breakpoints: Móvil < 600dp, Tablet 600-850dp, Desktop >= 850dp
    final isTablet = size.width >= 600 && size.width < 850;
    final isDesktop = size.width >= 850;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calcular dimensiones responsivas
          double horizontalPadding;
          double maxFormWidth;
          double logoSize;
          double verticalSpacing;

          if (isDesktop) {
            horizontalPadding = constraints.maxWidth * 0.3;
            maxFormWidth = 500;
            logoSize = 120;
            verticalSpacing = 40;
          } else if (isTablet) {
            horizontalPadding = constraints.maxWidth * 0.15;
            maxFormWidth = 500;
            logoSize = 100;
            verticalSpacing = 30;
          } else {
            horizontalPadding = isPortrait ? 24 : constraints.maxWidth * 0.1;
            maxFormWidth = constraints.maxWidth;
            logoSize = isPortrait ? 80 : 60;
            verticalSpacing = isPortrait ? 30 : 20;
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade700, Colors.blue.shade900],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxFormWidth),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Logo/Icono
                          FractionallySizedBox(
                            widthFactor: isPortrait ? 0.4 : 0.25,
                            child: Container(
                              height: logoSize,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.shopping_bag_rounded,
                                size: logoSize * 0.6,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                          SizedBox(height: verticalSpacing),

                          // Título
                          Text(
                            'Tienda Online',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isDesktop ? 36 : (isTablet ? 32 : 28),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: verticalSpacing * 0.3),
                          Text(
                            'Inicia sesión para continuar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isDesktop ? 18 : 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: verticalSpacing),

                          // Tarjeta del formulario
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                isDesktop ? 32 : (isTablet ? 28 : 24),
                              ),
                              child: Column(
                                children: [
                                  // Campo de usuario
                                  TextFormField(
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      labelText: 'Usuario',
                                      prefixIcon: const Icon(Icons.person),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor ingresa tu usuario';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: verticalSpacing * 0.6),

                                  // Campo de contraseña
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    decoration: InputDecoration(
                                      labelText: 'Contraseña',
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor ingresa tu contraseña';
                                      }
                                      if (value.length < 4) {
                                        return 'La contraseña debe tener al menos 4 caracteres';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: verticalSpacing * 0.4),

                                  // Enlace "¿Olvidaste tu contraseña?"
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Función de recuperación de contraseña',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        '¿Olvidaste tu contraseña?',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: verticalSpacing * 0.4),

                                  // Botón de login
                                  SizedBox(
                                    width: double.infinity,
                                    height: isDesktop ? 56 : 50,
                                    child: ElevatedButton(
                                      onPressed: _handleLogin,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade700,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 3,
                                      ),
                                      child: Text(
                                        'Iniciar Sesión',
                                        style: TextStyle(
                                          fontSize: isDesktop ? 18 : 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: verticalSpacing * 0.6),

                          // Enlace de registro
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '¿No tienes cuenta? ',
                                style: TextStyle(color: Colors.white70),
                              ),
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Función de registro'),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Regístrate',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
