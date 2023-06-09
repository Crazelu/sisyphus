import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/views/trade_details/widgets/trade_modal.dart';
import 'package:sissyphus/presentation/widgets/custom_button.dart';
import 'package:sissyphus/presentation/widgets/custom_tab_bar.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class UserTradingActivitySection extends StatefulWidget {
  const UserTradingActivitySection({super.key});

  @override
  State<UserTradingActivitySection> createState() =>
      _UserTradingActivitySectionState();
}

class _UserTradingActivitySectionState
    extends State<UserTradingActivitySection> {
  int _index = 0;

  void _setIndex(int value) {
    if (_index != value) {
      setState(() {
        _index = value;
      });
    }
  }

  String get _title {
    switch (_index) {
      case 0:
        return "No Open Orders";
      case 1:
        return "No Positions";
      case 2:
        return "No Order History";
      default:
        return "";
    }
  }

  String get _description {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.";
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: palette.cardColor,
          child: Column(
            children: [
              const Gap(12),
              CustomTabBar(
                index: _index,
                tabs: const [
                  "Open Orders",
                  "Positions",
                  "Order History",
                ],
                onChanged: _setIndex,
              ),
              const Gap(8 * 14),
              CustomText(
                text: _title,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              const Gap(16),
              SizedBox(
                width: 294,
                child: CustomText(
                  text: _description,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                  textAlign: TextAlign.center,
                  height: 1.6,
                ),
              ),
              const Gap(36),
            ],
          ),
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: CustomButton.buy(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => const TradeModal(),
                    );
                  },
                ),
              ),
              const Gap(12),
              Expanded(
                child: CustomButton.sell(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => const TradeModal(index: 1),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
