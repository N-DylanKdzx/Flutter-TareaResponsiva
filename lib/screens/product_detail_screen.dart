import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    final isPhone = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 850;
    final isDesktop = size.width >= 850;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Compartir producto')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Agregado a favoritos')),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Móvil vertical: diseño en columna
          if (isPhone && isPortrait) {
            return _buildMobilePortraitLayout(context, constraints);
          }
          // Móvil horizontal: diseño en fila
          else if (isPhone && !isPortrait) {
            return _buildMobileLandscapeLayout(context, constraints);
          }
          // Tablet y Desktop: diseño en fila con proporciones
          else {
            return _buildTabletDesktopLayout(
              context,
              constraints,
              isTablet,
              isDesktop,
            );
          }
        },
      ),
    );
  }

  // Layout para móvil vertical
  Widget _buildMobilePortraitLayout(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del producto (40-50% de altura)
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Container(
              height: constraints.maxHeight * 0.45,
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
          ),

          // Información del producto
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Descripción',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 24),

                // Botones de acción
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} agregado al carrito'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text(
                      'Agregar al Carrito',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Compra iniciada')),
                      );
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text(
                      'Comprar Ahora',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue.shade700,
                      side: BorderSide(color: Colors.blue.shade700, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Layout para móvil horizontal
  Widget _buildMobileLandscapeLayout(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del producto (50% del ancho)
          Flexible(
            flex: 1,
            child: Container(
              height: constraints.maxHeight,
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 60,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
          ),

          // Información del producto (50% del ancho)
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      product.price,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Descripción',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Botones de acción
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} agregado al carrito',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart, size: 18),
                      label: const Text(
                        'Agregar',
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Compra iniciada')),
                        );
                      },
                      icon: const Icon(Icons.payment, size: 18),
                      label: const Text(
                        'Comprar',
                        style: TextStyle(fontSize: 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade700,
                        side: BorderSide(color: Colors.blue.shade700, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Layout para tablet y desktop
  Widget _buildTabletDesktopLayout(
    BuildContext context,
    BoxConstraints constraints,
    bool isTablet,
    bool isDesktop,
  ) {
    // Proporciones: Tablet (60-40), Desktop (centrado con max width)
    final imageFlex = isTablet ? 6 : 1;
    final infoFlex = isTablet ? 4 : 1;
    final maxWidth = isDesktop ? 1200.0 : double.infinity;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Flexible(
              flex: imageFlex,
              child: Container(
                height: constraints.maxHeight,
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.grey.shade400,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Panel de información
            Flexible(
              flex: infoFlex,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isDesktop ? 40 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: isDesktop ? 36 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isDesktop ? 20 : 16),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 20 : 16,
                        vertical: isDesktop ? 12 : 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        product.price,
                        style: TextStyle(
                          fontSize: isDesktop ? 32 : 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: isDesktop ? 32 : 24),
                    Text(
                      'Descripción del Producto',
                      style: TextStyle(
                        fontSize: isDesktop ? 22 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isDesktop ? 16 : 12),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: isDesktop ? 18 : 16,
                        height: 1.8,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: isDesktop ? 32 : 24),

                    // Características adicionales
                    _buildFeatureItem(
                      Icons.local_shipping,
                      'Envío gratis',
                      'En compras mayores a \$50',
                      isDesktop,
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      Icons.verified_user,
                      'Garantía',
                      '12 meses de garantía oficial',
                      isDesktop,
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      Icons.replay,
                      'Devoluciones',
                      '30 días para devoluciones',
                      isDesktop,
                    ),
                    SizedBox(height: isDesktop ? 40 : 32),

                    // Botones de acción
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: SizedBox(
                        height: isDesktop ? 60 : 54,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.name} agregado al carrito',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart, size: 24),
                          label: Text(
                            'Agregar al Carrito',
                            style: TextStyle(
                              fontSize: isDesktop ? 18 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: SizedBox(
                        height: isDesktop ? 60 : 54,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Compra iniciada')),
                            );
                          },
                          icon: const Icon(Icons.payment, size: 24),
                          label: Text(
                            'Comprar Ahora',
                            style: TextStyle(
                              fontSize: isDesktop ? 18 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue.shade700,
                            side: BorderSide(
                              color: Colors.blue.shade700,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    IconData icon,
    String title,
    String subtitle,
    bool isDesktop,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.blue.shade700,
            size: isDesktop ? 24 : 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: isDesktop ? 14 : 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
