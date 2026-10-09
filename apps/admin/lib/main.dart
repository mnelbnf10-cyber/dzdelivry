
import 'package:flutter/material.dart';

void main() {
  runApp(const DzDeliveryAdmin());
}

const Color primaryColor = Color(0xFF6C3CE9);
const Color backgroundColor = Color(0xFFF7F7FC);
const Color darkColor = Color(0xFF211A35);

class DzDeliveryAdmin extends StatelessWidget {
  const DzDeliveryAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DzDelivery Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: darkColor,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const AdminHomePage(),
    );
  }
}

class Product {
  Product({
    required this.name,
    required this.category,
    required this.price,
    this.available = true,
  });

  String name;
  String category;
  double price;
  bool available;
}

class DeliveryOrder {
  DeliveryOrder({
    required this.id,
    required this.customer,
    required this.address,
    required this.total,
    this.status = 'جديد',
  });

  final String id;
  final String customer;
  final String address;
  final double total;
  String status;
}

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int selectedPage = 0;

  final List<Product> products = [
    Product(
      name: 'بيتزا مارغريتا',
      category: 'بيتزا',
      price: 850,
    ),
    Product(
      name: 'برغر دجاج',
      category: 'وجبات سريعة',
      price: 650,
    ),
    Product(
      name: 'طاكوس دجاج',
      category: 'طاكوس',
      price: 700,
    ),
    Product(
      name: 'شاورما',
      category: 'ساندويتش',
      price: 450,
    ),
  ];

  final List<DeliveryOrder> orders = [
    DeliveryOrder(
      id: 'DZ-1001',
      customer: 'محمد',
      address: 'الشلف - وسط المدينة',
      total: 1500,
      status: 'جديد',
    ),
    DeliveryOrder(
      id: 'DZ-1002',
      customer: 'ياسين',
      address: 'وادي الفضة',
      total: 950,
      status: 'قيد التحضير',
    ),
    DeliveryOrder(
      id: 'DZ-1003',
      customer: 'أمين',
      address: 'الشلف - حي السلام',
      total: 2100,
      status: 'تم التوصيل',
    ),
  ];

  int get newOrders =>
      orders.where((order) => order.status == 'جديد').length;

  double get totalRevenue => orders
      .where((order) => order.status == 'تم التوصيل')
      .fold(0.0, (sum, order) => sum + order.total);

  String get pageTitle {
    switch (selectedPage) {
      case 1:
        return 'إدارة الطلبات';
      case 2:
        return 'إدارة المنتجات';
      case 3:
        return 'الإحصائيات';
      default:
        return 'لوحة التحكم';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.delivery_dining,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DzDelivery',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'لوحة الإدارة',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'الإشعارات',
              onPressed: () => _showMessage(
                'لديك $newOrders طلبات جديدة',
              ),
              icon: Badge(
                isLabelVisible: newOrders > 0,
                label: Text('$newOrders'),
                child: const Icon(Icons.notifications_none),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Row(
          children: [
            if (MediaQuery.sizeOf(context).width >= 700)
              _buildSidebar(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      12,
                    ),
                    child: Text(
                      pageTitle,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: darkColor,
                      ),
                    ),
                  ),
                  Expanded(child: _buildCurrentPage()),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            MediaQuery.sizeOf(context).width < 700
                ? NavigationBar(
                    selectedIndex: selectedPage,
                    onDestinationSelected: (index) {
                      setState(() => selectedPage = index);
                    },
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: 'الرئيسية',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.receipt_long_outlined),
                        selectedIcon: Icon(Icons.receipt_long),
                        label: 'الطلبات',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.inventory_2_outlined),
                        selectedIcon: Icon(Icons.inventory_2),
                        label: 'المنتجات',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.bar_chart_outlined),
                        selectedIcon: Icon(Icons.bar_chart),
                        label: 'الإحصائيات',
                      ),
                    ],
                  )
                : null,
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 225,
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Text(
            'القائمة الرئيسية',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          _menuItem(0, Icons.dashboard_outlined, 'لوحة التحكم'),
          _menuItem(1, Icons.receipt_long_outlined, 'الطلبات'),
          _menuItem(2, Icons.inventory_2_outlined, 'المنتجات'),
          _menuItem(3, Icons.bar_chart_outlined, 'الإحصائيات'),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF0EBFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.support_agent, color: primaryColor),
                SizedBox(height: 8),
                Text(
                  'DzDelivery Admin',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'إدارة التوصيل بسهولة',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(int index, IconData icon, String label) {
    final selected = selectedPage == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        selected: selected,
        selectedTileColor: const Color(0xFFF0EBFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        leading: Icon(
          icon,
          color: selected ? primaryColor : Colors.grey,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? primaryColor : darkColor,
            fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () => setState(() => selectedPage = index),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (selectedPage) {
      case 1:
        return _buildOrdersPage();
      case 2:
        return _buildProductsPage();
      case 3:
        return _buildStatisticsPage();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6C3CE9),
                Color(0xFF9270F4),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً بك في DzDelivery 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'تابع طلباتك ومنتجاتك من مكان واحد.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 850
                ? 4
                : constraints.maxWidth >= 500
                    ? 2
                    : 1;

            final cards = [
              _statCard(
                'الطلبات',
                '${orders.length}',
                Icons.receipt_long,
                const Color(0xFF6C3CE9),
              ),
              _statCard(
                'طلبات جديدة',
                '$newOrders',
                Icons.notifications_active_outlined,
                const Color(0xFFFF9800),
              ),
              _statCard(
                'المنتجات',
                '${products.length}',
                Icons.inventory_2_outlined,
                const Color(0xFF009688),
              ),
              _statCard(
                'المبيعات المكتملة',
                '${totalRevenue.toStringAsFixed(0)} دج',
                Icons.payments_outlined,
                const Color(0xFF2196F3),
              ),
            ];

            return GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: columns == 1 ? 2.6 : 1.45,
              children: cards,
            );
          },
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'أحدث الطلبات',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => setState(() => selectedPage = 1),
              child: const Text('عرض الكل'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (orders.isEmpty)
          _emptyState('لا توجد طلبات حتى الآن')
        else
          ...orders.take(3).map(_orderCard),
      ],
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersPage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${orders.length} طلب',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  orders.sort((a, b) => a.id.compareTo(b.id));
                });
              },
              icon: const Icon(Icons.sort),
              label: const Text('ترتيب'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (orders.isEmpty)
          _emptyState('لا توجد طلبات')
        else
          ...orders.map(_orderCard),
      ],
    );
  }

  Widget _orderCard(DeliveryOrder order) {
    final color = _statusColor(order.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _infoLine(Icons.person_outline, order.customer),
          const SizedBox(height: 7),
          _infoLine(Icons.location_on_outlined, order.address),
          const SizedBox(height: 7),
          _infoLine(
            Icons.payments_outlined,
            '${order.total.toStringAsFixed(0)} دج',
          ),
          const SizedBox(height: 14),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: PopupMenuButton<String>(
              tooltip: 'تغيير الحالة',
              onSelected: (status) {
                setState(() => order.status = status);
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'جديد',
                  child: Text('جديد'),
                ),
                PopupMenuItem(
                  value: 'قيد التحضير',
                  child: Text('قيد التحضير'),
                ),
                PopupMenuItem(
                  value: 'في الطريق',
                  child: Text('في الطريق'),
                ),
                PopupMenuItem(
                  value: 'تم التوصيل',
                  child: Text('تم التوصيل'),
                ),
                PopupMenuItem(
                  value: 'ملغى',
                  child: Text('ملغى'),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 17,
                      color: primaryColor,
                    ),
                    SizedBox(width: 7),
                    Text(
                      'تغيير الحالة',
                      style: TextStyle(color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoLine(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildProductsPage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${products.length} منتجات',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            FilledButton.icon(
              onPressed: _showAddProductDialog,
              icon: const Icon(Icons.add),
              label: const Text('إضافة منتج'),
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (products.isEmpty)
          _emptyState('لا توجد منتجات. أضف منتجك الأول.')
        else
          ...products.map(_productCard),
      ],
    );
  }

  Widget _productCard(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EBFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.fastfood_outlined,
              color: primaryColor,
              size: 27,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${product.price.toStringAsFixed(0)} دج',
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Switch(
                value: product.available,
                activeTrackColor: primaryColor,
                onChanged: (value) {
                  setState(() => product.available = value);
                },
              ),
              IconButton(
                tooltip: 'حذف المنتج',
                onPressed: () => _confirmDeleteProduct(product),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final priceController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('إضافة منتج جديد'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المنتج',
                  prefixIcon: Icon(Icons.fastfood_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'التصنيف',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'السعر بالدينار',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              final category = categoryController.text.trim();
              final price = double.tryParse(
                priceController.text.trim(),
              );

              if (name.isEmpty ||
                  category.isEmpty ||
                  price == null ||
                  price <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('أدخل معلومات صحيحة للمنتج'),
                  ),
                );
                return;
              }

              setState(() {
                products.add(
                  Product(
                    name: name,
                    category: category,
                    price: price,
                  ),
                );
              });

              Navigator.pop(dialogContext);
              _showMessage('تمت إضافة المنتج بنجاح');
            },
            style: FilledButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            child: const Text('حفظ المنتج'),
          ),
        ],
      ),
    ).then((_) {
      nameController.dispose();
      categoryController.dispose();
      priceController.dispose();
    });
  }

  void _confirmDeleteProduct(Product product) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف المنتج'),
        content: Text('هل تريد حذف "${product.name}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              setState(() => products.remove(product));
              Navigator.pop(dialogContext);
              _showMessage('تم حذف المنتج');
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsPage() {
    final delivered =
        orders.where((order) => order.status == 'تم التوصيل').length;
    final preparing =
        orders.where((order) => order.status == 'قيد التحضير').length;
    final onTheWay =
        orders.where((order) => order.status == 'في الطريق').length;
    final cancelled =
        orders.where((order) => order.status == 'ملغى').length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      children: [
        _statCard(
          'إجمالي الطلبات',
          '${orders.length}',
          Icons.receipt_long,
          primaryColor,
        ),
        const SizedBox(height: 12),
        _statCard(
          'إجمالي المبيعات المكتملة',
          '${totalRevenue.toStringAsFixed(0)} دج',
          Icons.payments_outlined,
          Colors.green,
        ),
        const SizedBox(height: 22),
        const Text(
          'حالة الطلبات',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _statisticsRow('جديد', newOrders, Colors.orange),
        _statisticsRow('قيد التحضير', preparing, Colors.blue),
        _statisticsRow('في الطريق', onTheWay, primaryColor),
        _statisticsRow('تم التوصيل', delivered, Colors.green),
        _statisticsRow('ملغى', cancelled, Colors.red),
        const SizedBox(height: 18),
        const Text(
          'ملاحظة: هذه الإحصائيات محسوبة من بيانات تجريبية محفوظة داخل التطبيق.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _statisticsRow(String title, int count, Color color) {
    final maxCount = orders.isEmpty ? 1 : orders.length;
    final progress = count / maxCount;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(title)),
              Text(
                '$count',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
            color: color,
            backgroundColor: const Color(0xFFF0F0F5),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.inbox_outlined,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'جديد':
        return Colors.orange;
      case 'قيد التحضير':
        return Colors.blue;
      case 'في الطريق':
        return primaryColor;
      case 'تم التوصيل':
        return Colors.green;
      case 'ملغى':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
