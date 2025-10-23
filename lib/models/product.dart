class Product {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // Lista de productos de ejemplo
  static List<Product> getSampleProducts() {
    return [
      Product(
        id: '1',
        name: 'Laptop Gaming Pro',
        price: '\$1,299.99',
        description:
            'Laptop de alto rendimiento con procesador Intel i7, 16GB RAM, GPU RTX 4060, pantalla 15.6 pulgadas Full HD. Ideal para gaming y edición de video. Incluye teclado retroiluminado RGB y sistema de refrigeración avanzado.',
        imageUrl:
            'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500',
      ),
      Product(
        id: '2',
        name: 'Smartphone X12',
        price: '\$899.99',
        description:
            'Smartphone con pantalla AMOLED de 6.5 pulgadas, cámara triple de 108MP, batería de 5000mAh, 256GB de almacenamiento. Procesador de última generación con conectividad 5G y carga rápida de 65W.',
        imageUrl:
            'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',
      ),
      Product(
        id: '3',
        name: 'Auriculares Bluetooth Pro',
        price: '\$199.99',
        description:
            'Auriculares inalámbricos con cancelación de ruido activa, 30 horas de batería, sonido Hi-Fi y micrófono incorporado. Diseño ergonómico con almohadillas de memoria y controles táctiles intuitivos.',
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      ),
      Product(
        id: '4',
        name: 'Tablet Ultra 2024',
        price: '\$649.99',
        description:
            'Tablet de 11 pulgadas con procesador de última generación, 8GB RAM, 128GB almacenamiento, ideal para productividad y entretenimiento. Incluye soporte para stylus y teclado magnético opcional.',
        imageUrl:
            'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=500',
      ),
      Product(
        id: '5',
        name: 'Smartwatch Fitness',
        price: '\$249.99',
        description:
            'Reloj inteligente con monitor de frecuencia cardíaca, GPS integrado, resistente al agua, más de 50 modos deportivos. Pantalla AMOLED siempre activa, medidor de oxígeno en sangre y análisis del sueño.',
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
      ),
      Product(
        id: '6',
        name: 'Cámara Mirrorless 4K',
        price: '\$1,499.99',
        description:
            'Cámara profesional con sensor full frame, grabación en 4K 60fps, estabilización de imagen, pantalla táctil abatible. Perfecta para fotografía profesional y creación de contenido con enfoque automático inteligente.',
        imageUrl:
            'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=500',
      ),
    ];
  }
}
