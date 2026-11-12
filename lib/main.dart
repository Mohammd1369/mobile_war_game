import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const LifeOsApp());

class LifeOsApp extends StatefulWidget {
  const LifeOsApp({super.key});

  @override
  State<LifeOsApp> createState() => _LifeOsAppState();
}

class _LifeOsAppState extends State<LifeOsApp> {
  Locale _locale = const Locale('fa');

  void _toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'fa'
          ? const Locale('en')
          : const Locale('fa');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LIFE OS',
      locale: _locale,
      supportedLocales: const [Locale('fa'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08111F),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8C7CFF),
          secondary: Color(0xFF53D6D0),
          surface: Color(0xFF121F33),
        ),
        useMaterial3: true,
        fontFamily: _locale.languageCode == 'fa' ? null : 'Roboto',
      ),
      home: HomeScreen(
        locale: _locale,
        onToggleLocale: _toggleLocale,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.locale,
    required this.onToggleLocale,
  });

  final Locale locale;
  final VoidCallback onToggleLocale;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _missionDone = false;

  bool get isFa => widget.locale.languageCode == 'fa';
  String tr(String fa, String en) => isFa ? fa : en;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homeContent(),
      _simplePage(
        Icons.flag_rounded,
        tr('مسیر من', 'My Path'),
        tr('هدف‌هایت را انتخاب کن و قدم‌به‌قدم پیش برو.', 'Choose your goals and move forward, one step at a time.'),
      ),
      _simplePage(
        Icons.bolt_rounded,
        tr('مأموریت‌ها', 'Missions'),
        tr('اقدام‌های کوچک، تغییرهای واقعی می‌سازند.', 'Small actions create real change.'),
      ),
      _simplePage(
        Icons.insights_rounded,
        tr('پیشرفت من', 'My Progress'),
        tr('پیشرفت خود را در طول زمان دنبال کن.', 'Track your progress over time.'),
      ),
    ];

    return Directionality(
      textDirection: isFa ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) => setState(() => _selectedIndex = value),
          backgroundColor: const Color(0xFF0D192A),
          indicatorColor: const Color(0xFF302B5D),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_rounded),
              label: tr('خانه', 'Home'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.flag_rounded),
              label: tr('مسیر من', 'My Path'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.bolt_rounded),
              label: tr('مأموریت', 'Mission'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.insights_rounded),
              label: tr('پیشرفت', 'Progress'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [Color(0xFF8C7CFF), Color(0xFF53D6D0)],
                ),
              ),
              child: const Icon(Icons.all_inclusive_rounded, color: Colors.white, size: 29),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LIFE OS', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: 1.4)),
                  Text('YOUR LIFE. YOUR PATH.', style: TextStyle(fontSize: 9, color: Color(0xFF9EABC1), letterSpacing: 1.5)),
                ],
              ),
            ),
            IconButton(
              tooltip: tr('تغییر زبان', 'Switch language'),
              onPressed: widget.onToggleLocale,
              icon: const Icon(Icons.language_rounded, color: Color(0xFFBFC9DD)),
            ),
            CircleAvatar(
              backgroundColor: const Color(0xFF1C2B45),
              child: const Icon(Icons.person_outline_rounded, color: Color(0xFFBFC9DD)),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF28275B), Color(0xFF142A43), Color(0xFF102C35)],
            ),
            border: Border.all(color: Colors.white.withOpacity(.09)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr('خوش آمدی', 'WELCOME BACK'), style: const TextStyle(color: Color(0xFFB9C5E2), fontSize: 12, letterSpacing: 1.1)),
              const SizedBox(height: 8),
              Text(
                tr('امروز، یک شروع تازه است.', 'Today is a fresh start.'),
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800, height: 1.35),
              ),
              const SizedBox(height: 9),
              Text(
                tr('لازم نیست همه‌چیز را یک‌باره تغییر بدهی؛ فقط یک قدم بردار.', 'You do not have to change everything at once. Just take one step.'),
                style: const TextStyle(color: Color(0xFFD0D8E8), height: 1.6, fontSize: 13),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _metric(tr('مأموریت امروز', 'TODAY'), _missionDone ? '1/1' : '0/1'),
                  const SizedBox(width: 12),
                  _metric(tr('وضعیت مسیر', 'YOUR PATH'), tr('در آغاز', 'Getting started')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        _sectionTitle(tr('نقشه زندگی من', 'MY LIFE MAP'), tr('حوزه‌هایی برای رشد متعادل', 'Areas for balanced growth')),
        const SizedBox(height: 13),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 11,
          crossAxisSpacing: 11,
          childAspectRatio: 1.48,
          children: [
            _lifeArea(Icons.favorite_outline_rounded, tr('سلامت و آرامش', 'Health & wellbeing'), const Color(0xFF53D6D0)),
            _lifeArea(Icons.people_alt_outlined, tr('روابط انسانی', 'Relationships'), const Color(0xFFFFA77A)),
            _lifeArea(Icons.account_balance_wallet_outlined, tr('مالی و شغلی', 'Finance & career'), const Color(0xFF9E91FF)),
            _lifeArea(Icons.auto_stories_rounded, tr('یادگیری', 'Learning'), const Color(0xFFF4C86A)),
            _lifeArea(Icons.explore_outlined, tr('هدف و معنا', 'Purpose & meaning'), const Color(0xFF83B7FF)),
            _lifeArea(Icons.spa_outlined, tr('رشد شخصی', 'Personal growth'), const Color(0xFFEA91C7)),
          ],
        ),
        const SizedBox(height: 25),
        _sectionTitle(tr('یک قدم کوچک امروز', 'ONE SMALL STEP TODAY'), tr('پیشرفت با عمل ساخته می‌شود', 'Progress is built through action')),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color(0xFF121F33),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(.07)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.wb_sunny_outlined, color: Color(0xFFF4C86A)),
                  const SizedBox(width: 9),
                  Expanded(child: Text(tr('۱۰ دقیقه برای فکر کردن به یک تغییر مهم وقت بگذار.', 'Take 10 minutes to think about one meaningful change.'), style: const TextStyle(fontWeight: FontWeight.w600, height: 1.5))),
                ],
              ),
              const SizedBox(height: 14),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _missionDone,
                activeColor: const Color(0xFF53D6D0),
                onChanged: (value) => setState(() => _missionDone = value ?? false),
                title: Text(tr('این مأموریت را انجام دادم', 'I completed this mission'), style: const TextStyle(fontSize: 13)),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              if (_missionDone)
                Text(tr('آفرین! اولین قدمت ثبت شد.', 'Great! Your first step is marked.'), style: const TextStyle(color: Color(0xFF53D6D0), fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            tr('زندگی‌ات را فقط نگذران؛ آن را طراحی کن.', 'Do not just live your life. Design it.'),
            style: const TextStyle(color: Color(0xFF8190A9), fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget _metric(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.08),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFFB8C5DC), fontSize: 10)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: .3)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Color(0xFF8D9BB2), fontSize: 11)),
      ],
    );
  }

  Widget _lifeArea(IconData icon, String title, Color accent) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFF121F33),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(.055)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: accent, size: 23),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _simplePage(IconData icon, String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 54, color: const Color(0xFF9E91FF)),
            const SizedBox(height: 18),
            Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 9),
            Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF9EABC1), height: 1.6)),
            const SizedBox(height: 18),
            Text(tr('این بخش در مرحله بعد تکمیل می‌شود.', 'This section will be built in the next phase.'), style: const TextStyle(color: Color(0xFF71819A), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
