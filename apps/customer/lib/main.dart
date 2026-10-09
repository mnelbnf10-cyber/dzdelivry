import 'package:flutter/material.dart';

void main() => runApp(const DzDeliveryApp());

const purple = Color(0xFF8959DA);
const darkPurple = Color(0xFF6540B4);
const background = Color(0xFFFAF8FD);
const ink = Color(0xFF29243B);
const muted = Color(0xFF89849A);

class DzDeliveryApp extends StatelessWidget {
  const DzDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DzDelivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isRegister = false;
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (!emailController.text.contains('@') ||
        passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('أدخل بريدًا صحيحًا وكلمة مرور من 6 أحرف على الأقل'),
        ),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'DzDelivery',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: ink,
                      ),
                    ),
                    const Text(
                      'ذوقك المفضل حتى لباب دارك',
                      style: TextStyle(color: muted),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFBDA1F1), purple, darkPurple],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'جوعان؟ 🍔',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'اكتشف المحلات والوجبات القريبة منك واطلب بسهولة.',
                            style: TextStyle(
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      isRegister ? 'أنشئ حسابك' : 'مرحبا بعودتك 👋',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: ink,
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: login,
                        style: FilledButton.styleFrom(
                          backgroundColor: purple,
                        ),
                        child: Text(
                          isRegister ? 'إنشاء الحساب' : 'تسجيل الدخول',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isRegister = !isRegister;
                        });
                      },
                      child: Text(
                        isRegister
                            ? 'لديك حساب؟ سجّل الدخول'
                            : 'ليس لديك حساب؟ أنشئ حسابًا',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Meal {
  final String name;
  final String shop;
  final String emoji;
  final String category;
  final int price;
  final Color color;

  const Meal({
    required this.name,
    required this.shop,
    required this.emoji,
    required this.category,
    required this.price,
    required this.color,
  });
}

const meals = <Meal>[
  Meal(
    name: 'برغر دجاج',
    shop: 'Burger House',
    emoji: '🍔',
    category: 'برغر',
    price: 650,
    color: Color(0xFFFFE7D9),
  ),
  Meal(
    name: 'بيتزا مارغريتا',
    shop: 'Pizza Roma',
    emoji: '🍕',
    category: 'بيتزا',
    price: 950,
    color: Color(0xFFFFEAC8),
  ),
  Meal(
    name: 'تاكوس ميكس',
    shop: 'Tacos City',
    emoji: '🌯',
    category: 'تاكوس',
    price: 800,
    color: Color(0xFFE7F4DA),
  ),
  Meal(
    name: 'شاورما دجاج',
    shop: 'Le Snack',
    emoji: '🥙',
    category: 'شاورما',
    price: 550,
    color: Color(0xFFFFE6EA),
  ),
  Meal(
    name: 'كيكة الشوكولا',
    shop: 'Sweet Corner',
    emoji: '🍰',
    category: 'حلويات',
    price: 400,
    color: Color(0xFFF0E1FA),
  ),
  Meal(
    name: 'عصير فريش',
    shop: 'Juice Lab',
    emoji: '🧋',
    category: 'مشروبات',
    price: 300,
    color: Color(0xFFDDF5F0),
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  String selectedCategory = 'الكل';
  String searchQuery = '';

  final Map<String, int> cart = {};
  final List<Map<String, dynamic>> orders = [];

  int get cartCount => cart.values.fold(0, (sum, value) => sum + value);

  int get cartTotal {
    var total = 0;
    for (final meal in meals) {
      total += meal.price * (cart[meal.name] ?? 0);
    }
    return total;
  }

  List<Meal> get filteredMeals {
    return meals.where((meal) {
      final categoryMatches =
          selectedCategory == 'الكل' ||
          meal.category == selectedCategory;

      final query = searchQuery.toLowerCase();
      final searchMatches =
          meal.name.toLowerCase().contains(query) ||
          meal.shop.toLowerCase().contains(query);

      return categoryMatches && searchMatches;
    }).toList();
  }

  void addToCart(Meal meal) {
    setState(() {
      cart[meal.name] = (cart[meal.name] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة ${meal.name} إلى السلة'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'DzDelivery',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (_) => const LoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: IndexedStack(
          index: selectedTab,
          children: [
            buildHome(),
            buildShops(),
            buildOrders(),
            buildAccount(),
          ],
        ),
        floatingActionButton: selectedTab == 0
            ? FloatingActionButton.extended(
                onPressed: showCart,
                backgroundColor: purple,
                foregroundColor: Colors.white,
                icon: const Icon(Icons.shopping_bag_outlined),
                label: Text('السلة ($cartCount) • $cartTotal دج'),
              )
            : null,
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedTab,
          onDestinationSelected: (index) {
            setState(() {
              selectedTab = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined),
              label: 'المحلات',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              label: 'طلباتي',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHome() {
    final categories = [
      'الكل',
      'برغر',
      'بيتزا',
      'تاكوس',
      'شاورما',
      'حلويات',
      'مشروبات',
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFBDA1F1), purple, darkPurple],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'شهوتك علينا! 🍟',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'وجبات لذيذة وتوصيل سهل حتى لباب دارك.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'ابحث عن وجبة أو محل...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'التصنيفات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 44,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: selectedCategory == category,
                          showCheckmark: false,
                          selectedColor: purple,
                          labelStyle: TextStyle(
                            color: selectedCategory == category
                                ? Colors.white
                                : ink,
                          ),
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'اختياراتنا لك ✨',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final meal = filteredMeals[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: purple.withValues(alpha: 0.07),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: meal.color,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              meal.emoji,
                              style: const TextStyle(fontSize: 58),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meal.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              meal.shop,
                              style: const TextStyle(
                                color: muted,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${meal.price} دج',
                                    style: const TextStyle(
                                      color: darkPurple,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                IconButton.filled(
                                  onPressed: () => addToCart(meal),
                                  icon: const Icon(Icons.add),
                                  style: IconButton.styleFrom(
                                    backgroundColor: purple,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: filteredMeals.length,
            ),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.62,
                ),
          ),
        ),
      ],
    );
  }

  Widget buildShops() {
    final shops = meals.map((meal) => meal.shop).toSet().toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'اكتشف المحلات',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 15),
        ...shops.map((shop) {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFF1EAFB),
                child: Icon(Icons.storefront, color: purple),
              ),
              title: Text(
                shop,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: const Text('مأكولات • طلبات تجريبية'),
              trailing: const Icon(Icons.chevron_left),
            ),
          );
        }),
      ],
    );
  }

  Widget buildOrders() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'طلباتي',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        if (orders.isEmpty)
          const Padding(
            padding: EdgeInsets.all(35),
            child: Column(
              children: [
                Icon(Icons.receipt_long_outlined, size: 65, color: muted),
                SizedBox(height: 12),
                Text('لا توجد طلبات حتى الآن'),
              ],
            ),
          )
        else
          ...orders.map((order) {
            return Card(
              child: ListTile(
                leading: const Icon(
                  Icons.receipt_long,
                  color: purple,
                ),
                title: Text('طلب ${order['id']}'),
                subtitle: Text('${order['status']}'),
                trailing: Text('${order['total']} دج'),
              ),
            );
          }),
      ],
    );
  }

  Widget buildAccount() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 42,
          backgroundColor: Color(0xFFF1EAFB),
          child: Icon(Icons.person, size: 45, color: purple),
        ),
        const SizedBox(height: 15),
        const Text(
          'حسابي',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 18),
        const Card(
          child: ListTile(
            leading: Icon(Icons.location_on_outlined, color: purple),
            title: Text('عنوان التوصيل'),
            subtitle: Text('أضف عنوانك عند تأكيد الطلب'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.support_agent, color: purple),
            title: Text('المساعدة والدعم'),
            subtitle: Text('خدمة دعم الزبائن'),
          ),
        ),
      ],
    );
  }

  void showCart() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: StatefulBuilder(
            builder: (context, refresh) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'سلة المشتريات',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (cart.isEmpty)
                      const Text('السلة فارغة')
                    else
                      ...meals.where((meal) {
                        return (cart[meal.name] ?? 0) > 0;
                      }).map((meal) {
                        return ListTile(
                          title: Text(meal.name),
                          subtitle: Text('${meal.price} دج'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    final quantity = cart[meal.name] ?? 0;
                                    if (quantity <= 1) {
                                      cart.remove(meal.name);
                                    } else {
                                      cart[meal.name] = quantity - 1;
                                    }
                                  });
                                  refresh(() {});
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text('${cart[meal.name] ?? 0}'),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    cart[meal.name] =
                                        (cart[meal.name] ?? 0) + 1;
                                  });
                                  refresh(() {});
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        );
                      }),
                    const Divider(),
                    Text(
                      'المجموع: $cartTotal دج',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: cart.isEmpty
                            ? null
                            : () {
                                Navigator.pop(sheetContext);
                                showCheckout();
                              },
                        child: const Text('متابعة لتأكيد الطلب'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showCheckout() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'تأكيد الطلب',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'الاسم الكامل',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'رقم الهاتف',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'عنوان التوصيل',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (nameController.text.trim().isEmpty ||
                            phoneController.text.trim().isEmpty ||
                            addressController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('أكمل معلومات التوصيل'),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          orders.insert(0, {
                            'id': DateTime.now()
                                .millisecondsSinceEpoch
                                .toString()
                                .substring(8),
                            'total': cartTotal,
                            'status': 'تم استلام الطلب تجريبيًا',
                          });
                          cart.clear();
                          selectedTab = 2;
                        });

                        Navigator.pop(sheetContext);
                        nameController.dispose();
                        phoneController.dispose();
                        addressController.dispose();
                      },
                      child: const Text('تأكيد الطلب'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
