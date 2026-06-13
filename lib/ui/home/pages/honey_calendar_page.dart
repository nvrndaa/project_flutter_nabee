import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/data/model/response/transaction_response_model.dart';
import 'package:flutter_nabee/ui/home/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_nabee/ui/home/widget/honeycomb_widget.dart';
import 'package:flutter_nabee/ui/home/dialog/honey_saving_dialog.dart';
import 'package:flutter_nabee/ui/models/jar_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HoneyCalendarPage extends StatefulWidget {
  final JarModel jar;

  const HoneyCalendarPage({super.key, required this.jar});

  @override
  State<HoneyCalendarPage> createState() => _HoneyCalendarPageState();
}

class _HoneyCalendarPageState extends State<HoneyCalendarPage> {
  late DateTime _currentMonth;
  Set<int> _savedDays = {};
  bool _isLoading = true;
  int _moneySaved = 0;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
    _loadTransactions();
  }

  void _loadTransactions() {
    setState(() => _isLoading = true);
    context.read<TransactionBloc>().add(
          const TransactionEvent.fetchTransactions(),
        );
  }

  void _processTransactions(List<TransactionResponseModel> txns) {
    final jarTxns =
        txns.where((t) => t.honeyJarId == (widget.jar.id ?? -1));
    final saved = <int>{};
    int total = 0;
    for (final t in jarTxns) {
      final date = DateTime.tryParse(t.createdAt);
      if (date != null &&
          date.year == _currentMonth.year &&
          date.month == _currentMonth.month) {
        saved.add(date.day);
      }
      total += int.tryParse(t.amount) ?? 0;
    }
    if (mounted) {
      setState(() {
        _savedDays = saved;
        _moneySaved = total;
        _isLoading = false;
      });
    }
  }

  void _prevMonth() {
    setState(() {
      _currentMonth =
          DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
    _loadTransactions();
  }

  void _nextMonth() {
    setState(() {
      _currentMonth =
          DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
    _loadTransactions();
  }

  void showHoneySavingDialog(int day) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => HoneySavingDialog(
        day: day,
        month: _currentMonth.month,
        year: _currentMonth.year,
        honeyJarId: widget.jar.id ?? 0,
        onSaved: _loadTransactions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final jar = widget.jar;
    final target = int.tryParse(jar.price) ?? 1;
    final current = int.tryParse(jar.currentAmount) ?? 0;
    final progress = (current / target).clamp(0.0, 1.0);
    final percent = (progress * 100).toInt();
    final moneyLeft = target - _moneySaved;
    final monthLabel = DateFormat('MMMM, yyyy').format(_currentMonth);

    double hexWidth = screenWidth * 0.105;
    if (hexWidth > 42) hexWidth = 42;
    double hexHeight = hexWidth * 1.15;
    double honeyGridOverlapCompensation = hexHeight * 0.22;

    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final dayLists = _chunkDays(daysInMonth);

    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) => _processTransactions(data),
          error: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/images/sarang_lebah_atas.png",
                  width: 150,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: AppColors.brownText),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            jar.name,
                            style: const TextStyle(
                              color: AppColors.brownText,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          
                          // --- SUSUNAN BARU: PERSEN (ATAS) -> GARIS MERAH -> RP (BAWAH) ---
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Sisi Kiri: Botol Madu
                                Expanded(
                                  flex: 4,
                                  child: Image.asset(
                                    "assets/images/empty_jar.png",
                                    height: 200,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.bottomLeft,
                                  ),
                                ),
                                const SizedBox(width: 8), 
                                // Sisi Kanan: Susunan Teks & Garis Rata Kanan
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end, // Rata kanan
                                    children: [
                                      const Spacer(), // Mendorong isi komponen ke dasar area botol
                                      
                                      // 1. Persentase di atas garis (Ukuran dikecilkan dari 26 ke 18)
                                      Text(
                                        "$percent%",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.brownText,
                                            height: 1.0),
                                      ),
                                      const SizedBox(height: 6),
                                      
                                      // 2. Garis Putus-putus Merah (Di tengah-tengah teks)
                                      Row(
                                        children: List.generate(
                                          16,
                                          (index) => Expanded(
                                            child: Container(
                                              height: 2,
                                              margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                              color: AppColors.orange,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      
                                      // 3. Rupiah sekarang berada di bawah garis putus-putus
                                      Text(
                                        "Rp ${NumberFormat('#,###', 'id').format(_moneySaved)}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.brownText,
                                            height: 1.0),
                                      ),
                                      const SizedBox(height: 4), 
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: buildInfoCard(
                                  iconPath: "assets/icons/target_salved.svg",
                                  fallbackIcon: Icons.track_changes_rounded,
                                  title: "Due date",
                                  value: jar.endDate,
                                  valueColor: AppColors.brownText,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: buildInfoCard(
                                  iconPath: "assets/icons/coin.svg",
                                  fallbackIcon: Icons.monetization_on_rounded,
                                  title: "Money left",
                                  value: moneyLeft > 0
                                      ? "Rp ${NumberFormat('#,###', 'id').format(moneyLeft)}"
                                      : "LUNAS!",
                                  valueColor: moneyLeft > 0
                                      ? AppColors.orange
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFDF0),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Saving calendar",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.brownText,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          monthLabel,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: _prevMonth,
                                          child: Icon(Icons.chevron_left,
                                              color: Colors.grey[600], size: 24),
                                        ),
                                        const SizedBox(width: 12),
                                        GestureDetector(
                                          onTap: _nextMonth,
                                          child: Icon(Icons.chevron_right,
                                              color: Colors.grey[600], size: 24),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                _isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                              color: AppColors.orange),
                                        ),
                                      )
                                    : Center(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Column(
                                            children: [
                                              ...dayLists.map((row) {
                                                final isOffset =
                                                    dayLists.indexOf(row).isOdd;
                                                return buildHoneycombRow(
                                                  row,
                                                  isOffset: isOffset,
                                                  w: hexWidth,
                                                  h: hexHeight,
                                                  savedDays: _savedDays.toList(),
                                                  onDayTap: (day) {
                                                    if (!_savedDays.contains(day)) {
                                                      showHoneySavingDialog(day);
                                                    }
                                                  },
                                                );
                                              }),
                                              SizedBox(
                                                  height:
                                                      honeyGridOverlapCompensation),
                                            ],
                                          ),
                                        ),
                                      ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildLegendItem(
                                        const Color(0xffF5EEDB), "= Empty"),
                                    const SizedBox(width: 30),
                                    buildLegendItem(
                                        const Color(0xffFFAA2C), "= Saved"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<List<int>> _chunkDays(int totalDays) {
    final rows = <List<int>>[];
    int i = 1;
    while (i <= totalDays) {
      final row = <int>[];
      for (int j = 0; j < 6 && i <= totalDays; j++) {
        row.add(i);
        i++;
      }
      if (row.length < 6) {
        row.add(-1); // filler cell
      }
      rows.add(row);
    }
    return rows;
  }

  Widget buildInfoCard({
    required String iconPath,
    required IconData fallbackIcon,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppColors.orange.withValues(alpha: 0.6), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xffFEF5E7),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 22,
              height: 22,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(fallbackIcon, color: AppColors.orange, size: 22),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: valueColor,
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
}