import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_button.dart';
import 'package:sissyphus/presentation/widgets/custom_chip.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_tab_bar.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';
import 'package:sissyphus/presentation/widgets/gradient_button.dart';

class TradeModal extends StatefulWidget {
  final int index;
  const TradeModal({super.key, this.index = 0});

  @override
  State<TradeModal> createState() => _TradeModalState();
}

class _TradeModalState extends State<TradeModal> {
  int _tabIndex = 0;
  int _chipIndex = 0;

  void _setTabIndex(int value) {
    if (_tabIndex != value) {
      setState(() {
        _tabIndex = value;
      });
    }
  }

  void _setChipIndex(int value) {
    if (_chipIndex != value) {
      setState(() {
        _chipIndex = value;
      });
    }
  }

  @override
  void initState() {
    _tabIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: size.height * .75,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: palette.modalBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(
            color: palette.modalBorderColor,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              CustomTabBar(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                tabs: const ["Buy", "Sell"],
                selectedTabBorderColor: palette.buyButtonColor,
                index: _tabIndex,
                onChanged: _setTabIndex,
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomChip(
                    width: 56,
                    label: "Limit",
                    fontWeight: FontWeight.w700,
                    disableWidth: true,
                    selected: _chipIndex == 0,
                    onPressed: (_) {
                      _setChipIndex(0);
                    },
                  ),
                  CustomChip(
                    width: 64,
                    label: "Market",
                    fontWeight: FontWeight.w700,
                    disableWidth: true,
                    selected: _chipIndex == 1,
                    onPressed: (_) {
                      _setChipIndex(1);
                    },
                  ),
                  CustomChip(
                    width: 88,
                    label: "Stop Limit",
                    fontWeight: FontWeight.w700,
                    disableWidth: true,
                    selected: _chipIndex == 2,
                    onPressed: (_) {
                      _setChipIndex(2);
                    },
                  ),
                ],
              ),
              const Gap(16),
              const _TextField(
                prefix: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: _TextWithInfo("Limit price"),
                ),
              ),
              const Gap(16),
              const _TextField(
                prefix: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: _TextWithInfo("Amount"),
                ),
              ),
              const Gap(16),
              _TextField(
                enabled: false,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: _TextWithInfo("Type"),
                ),
                suffix: DropdownButton(
                  dropdownColor: palette.modalBackgroundColor,
                  underline: const SizedBox(),
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8) +
                        const EdgeInsets.only(right: 4),
                    child: CustomIcon(
                      iconPath: AppAssets.dropDown,
                      width: 8,
                      height: 8,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      child: CustomText(
                        text: "Good till cancelled",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  onChanged: (_) {},
                ),
              ),
              const Gap(16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    _CheckBox(),
                    Gap(8),
                    _TextWithInfo("Post Only"),
                  ],
                ),
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Total",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  CustomText(
                    text: "0.00",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
              const Gap(24),
              GradientButton(
                  buttonText: _tabIndex == 0 ? "Buy BTC" : "Sell BTC"),
              const Gap(2),
              const Divider(),
              const Gap(16),
              const _TotalAccountValueSection(),
              const Gap(24),
              CustomButton.deposit(onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

class _TextWithInfo extends StatelessWidget {
  final String text;
  const _TextWithInfo(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: text,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const Gap(4),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: CustomIcon(
            iconPath: AppAssets.info,
            width: 12,
            height: 12,
          ),
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;

  const _TextField({
    super.key,
    this.hint = "0.00 USD",
    this.enabled = true,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: palette.textFieldBorderColor),
      borderRadius: BorderRadius.circular(8),
    );

    return SizedBox(
      height: 48,
      child: TextField(
        cursorColor: Colors.white,
        enabled: enabled,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          hintText: suffix != null ? null : hint,
          hintStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary,
          ),
          disabledBorder: border,
          border: border,
          enabledBorder: border,
        ),
      ),
    );
  }
}

class _CheckBox extends StatefulWidget {
  const _CheckBox({super.key});

  @override
  State<_CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<_CheckBox> {
  bool _active = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _active = !_active;
        });
      },
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).extension<Palette>()!.textFieldBorderColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: _active
            ? Center(
                child: Icon(
                  Icons.check,
                  size: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

class _TotalAccountValueSection extends StatelessWidget {
  const _TotalAccountValueSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Total account value",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                CustomText(
                  text: "0.00",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const Spacer(),
            CustomText(
              text: "NGN",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const Gap(4),
            CustomIcon(
              iconPath: AppAssets.dropDown,
              width: 8,
              height: 8,
            ),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Open Orders",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                CustomText(
                  text: "0.00",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Available",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                CustomText(
                  text: "0.00",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
