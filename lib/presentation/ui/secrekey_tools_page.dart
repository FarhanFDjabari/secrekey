import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secrekey/presentation/bloc/tools/secrekey_tools_cubit.dart';
import 'package:secrekey/presentation/widgets/save_key_dialog.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/styles/text_styles.dart';

class SecreKeyToolsPage extends StatefulWidget {
  static const routeName = '/tools-page';

  const SecreKeyToolsPage({Key? key}) : super(key: key);

  @override
  _SecreKeyToolsPageState createState() => _SecreKeyToolsPageState();
}

class _SecreKeyToolsPageState extends State<SecreKeyToolsPage> {
  final TextEditingController _keyController = TextEditingController();
  int generatedKeyLength = 4;
  bool includeNum = false;
  bool includeSym = false;

  @override
  void dispose() {
    super.dispose();
    _keyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Generate Password',
                style: kTextTheme.headline5!.copyWith(
                  color: cBaseBlack,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Generated Password'.toUpperCase(),
                style: kTextTheme.subtitle1!.copyWith(
                  color: cMilkyGreyBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 75,
                decoration: BoxDecoration(
                  color: cMilkyGreyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: BlocBuilder<SecreKeyToolsCubit, SecrekeyToolsState>(
                    builder: (builderContext, state) {
                      if (state is SecrekeyToolsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: cMistyWhite,
                          ),
                        );
                      } else if (state is NewKeyGenerated) {
                        _keyController.text = state.newKey;
                        return TextField(
                          controller: _keyController,
                          style: kTextTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          enableInteractiveSelection: false,
                          readOnly: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            filled: true,
                            fillColor: cMilkyGreyBlue,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: _keyController.text,
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password Berhasil Disalin'),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.copy,
                                color: cMistyWhite,
                              ),
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              generatedKeyLength,
                              (index) => index > 20
                                  ? Container()
                                  : Text(
                                      '_ ',
                                      maxLines: 1,
                                      softWrap: true,
                                      style: kTextTheme.headline6!.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Length: $generatedKeyLength'.toUpperCase(),
                style: kTextTheme.subtitle1!.copyWith(
                  color: cMilkyGreyBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: cMilkyGreyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('4'),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          trackHeight: 1.0,
                          rangeThumbShape: RoundRangeSliderThumbShape(
                              enabledThumbRadius: 30, disabledThumbRadius: 30),
                        ),
                        child: Slider(
                          value: generatedKeyLength.toDouble(),
                          thumbColor: cMistyWhite,
                          activeColor: cMistyWhite,
                          onChanged: (value) {
                            setState(() {
                              generatedKeyLength = value.toInt();
                            });
                          },
                          min: 4,
                          max: 32,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text('32'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Options'.toUpperCase(),
                style: kTextTheme.subtitle1!.copyWith(
                  color: cMilkyGreyBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: cMilkyGreyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Include numbers',
                      style:
                          kTextTheme.subtitle1!.copyWith(color: Colors.white),
                    ),
                    CupertinoSwitch(
                      value: includeNum,
                      thumbColor: cMistyWhite,
                      activeColor: cDarkGreyBlue,
                      trackColor: cLightGreyBlue,
                      onChanged: (value) {
                        setState(() {
                          includeNum = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: cMilkyGreyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Include symbols',
                      style:
                          kTextTheme.subtitle1!.copyWith(color: Colors.white),
                    ),
                    CupertinoSwitch(
                      value: includeSym,
                      thumbColor: cMistyWhite,
                      activeColor: cDarkGreyBlue,
                      trackColor: cLightGreyBlue,
                      onChanged: (value) {
                        setState(() {
                          includeSym = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color: _keyController.text.isEmpty
                        ? Colors.grey
                        : cMilkyGreyBlue,
                    width: 1.5,
                  ),
                  primary: _keyController.text.isEmpty
                      ? Colors.grey
                      : cMilkyGreyBlue,
                ),
                onPressed: _keyController.text.isEmpty
                    ? null
                    : () {
                        _showSavePasswordModal(_keyController.text);
                      },
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      'Save Password'.toUpperCase(),
                      style: kTextTheme.button!.copyWith(
                        color: _keyController.text.isEmpty
                            ? Colors.grey
                            : cMilkyGreyBlue,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              BlocConsumer<SecreKeyToolsCubit, SecrekeyToolsState>(
                listener: (listenerContext, state) {
                  if (state is KeyGenerateFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: cLightMilkyPink,
                      ),
                    );
                  }
                },
                builder: (builderContext, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: cMilkyGreyBlue,
                      onPrimary: cDarkGreyBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      builderContext.read<SecreKeyToolsCubit>().generateKey(
                            generatedKeyLength,
                            includeNum,
                            includeSym,
                          );
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 56,
                      child: Center(
                        child: Text(
                          'Generate Password'.toUpperCase(),
                          style: kTextTheme.button!.copyWith(
                            color: cMistyWhite,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSavePasswordModal(String key) {
    showDialog(
      context: context,
      builder: (_) {
        return SaveKeyDialog(newKey: key);
      },
    );
  }
}
