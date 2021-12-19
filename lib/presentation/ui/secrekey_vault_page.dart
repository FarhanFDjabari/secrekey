import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secrekey/presentation/bloc/vault/secrekey_vault_cubit.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/styles/text_styles.dart';

class SecreKeyVaultPage extends StatefulWidget {
  static const routeName = '/vault-page';

  const SecreKeyVaultPage({Key? key}) : super(key: key);

  @override
  _SecreKeyVaultPageState createState() => _SecreKeyVaultPageState();
}

class _SecreKeyVaultPageState extends State<SecreKeyVaultPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<SecreKeyVaultCubit>(context).getAllSavedKey();
    });
  }

  void importKeyFromStorage(String directory) {}

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecreKeyVaultCubit, SecrekeyVaultState>(
      listener: (listenerContext, state) {
        if (state is SecrekeyVaultLoadFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: cLightMilkyPink,
            ),
          );
        } else if (state is SecrekeyVaultError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: cLightMilkyPink,
            ),
          );
        } else if (state is KeyRemoveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: cTealGreen,
            ),
          );
          listenerContext.read<SecreKeyVaultCubit>().getAllSavedKey();
        } else if (state is ExportKeySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: cTealGreen,
            ),
          );
          listenerContext.read<SecreKeyVaultCubit>().getAllSavedKey();
        } else if (state is ImportKeySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: cTealGreen,
            ),
          );
          listenerContext.read<SecreKeyVaultCubit>().getAllSavedKey();
        }
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'My Vault',
                    style: kTextTheme.headline5!.copyWith(
                      color: cBaseBlack,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  BlocBuilder<SecreKeyVaultCubit, SecrekeyVaultState>(
                    builder: (builderContext, state) {
                      return PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            onTap: () {
                              builderContext
                                  .read<SecreKeyVaultCubit>()
                                  .exportSavedKey();
                            },
                            height: 30,
                            child: Text(
                              'Export All Key',
                              style: kTextTheme.button!.copyWith(
                                color: cBaseBlack,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              importKeyFromStorage('');
                            },
                            height: 30,
                            child: Text(
                              'Import Key From Storage',
                              style: kTextTheme.button!.copyWith(
                                color: cBaseBlack,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                        child: const SizedBox(
                          height: 15,
                          child: Icon(
                            Icons.more_vert_outlined,
                            color: cBaseBlack,
                            size: 28,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            BlocBuilder<SecreKeyVaultCubit, SecrekeyVaultState>(
              builder: (builderContext, state) {
                if (state is SecrekeyVaultLoaded) {
                  if (state.generatedKeys.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.generatedKeys.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        itemBuilder: (_, index) => Container(
                          decoration: BoxDecoration(
                            color: cLightGreyBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: state.generatedKeys[index].key,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Password Berhasil Disalin'),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.generatedKeys[index].key,
                                      style: kTextTheme.subtitle1!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 11,
                                child: Center(
                                  child: Divider(
                                    height: 1,
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    state.generatedKeys[index].description,
                                    style: kTextTheme.bodyText2!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  PopupMenuButton(
                                    itemBuilder: (_) => [
                                      PopupMenuItem(
                                        onTap: () {
                                          builderContext
                                              .read<SecreKeyVaultCubit>()
                                              .removeSavedKey(
                                                state.generatedKeys[index],
                                              );
                                        },
                                        height: 15,
                                        child: Text(
                                          'Delete Saved Key',
                                          style: kTextTheme.button!.copyWith(
                                            color: cBaseBlack,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                    child: const SizedBox(
                                      height: 15,
                                      child: Icon(
                                        Icons.more_horiz_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Center(
                      child: Text(
                        'This Vault is Empty',
                        style: kTextTheme.subtitle2!.copyWith(
                          color: cBaseBlack,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: cMilkyGreyBlue,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
