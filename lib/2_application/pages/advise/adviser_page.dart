import 'package:flutter/material.dart';
import 'package:flutter_adviser/2_application/core/services/theme_service.dart';
import 'package:flutter_adviser/2_application/pages/advise/cubit/adviser_cubit.dart';
import 'package:flutter_adviser/2_application/pages/advise/widgets/advice_field.dart';
import 'package:flutter_adviser/2_application/pages/advise/widgets/custom_button.dart';
import 'package:flutter_adviser/2_application/pages/advise/widgets/error_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';

/*
* - so this is just a layer to provide the block for the adviser page,
* - every page gets its own wrapper and no other pages should have access 
*   the other pages's block
* - so for example only adviser page will access the adviser block 
*   and no other pages if any more.
*
* - it is basically a provider for this class so that we can have access to 
*   our bloc
*/
class AdViserPageWrapperProvider extends StatelessWidget {
  const AdViserPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: (context) => AdviserBloc(),
      create: (context) => sl<AdviserCubit>(),

      child: const AdviserPage(),
    );
  }
}

class AdviserPage extends StatelessWidget {
  const AdviserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adviser",
          style: themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Column(
          children: [
            Expanded(child: Center(
              /*
               TODO  BlocBuilder
               * 
               * - [BlocBuilder] handles building a widget in response to new
               *   `states`.
               * 
               * - basically with the help of this we execute code on basic of 
               *   which state has been called.
               * 
               * 
               ! NOTE = Please refer to [BlocListener] if you want to "do"
               !        anything in response to `state` changes such as 
               !        navigation,showing a dialog, etc...
               * 
               *
               *- implementation of [BlocBuilder] would be the same for bloc and 
               *  cubit.
               *
               
               */
              //BloC
              // child: BlocBuilder<AdviserBloc, AdviserState>(

              //Cubit
              child: BlocBuilder<AdviserCubit, AdviserCubitState>(
                  builder: (context, state) {
                if (state is AdviserInitial) {
                  return Text(
                    'Advice',
                    style: themeData.textTheme.displayLarge,
                  );
                } else if (state is AdviserStateLoading) {
                  return CircularProgressIndicator(
                    color: themeData.colorScheme.secondary,
                  );
                } else if (state is AdviserStateLoaded) {
                  return AdviceField(
                    advice: state.advice,
                  );
                } else if (state is AdviserStateError) {
                  return ErrorMessage(message: state.errorMessage);
                }
                return const ErrorMessage(
                    message: "Oops Something Went Wrong!!");
              }),
            )),
            const SizedBox(height: 200, child: Center(child: CustomButton())),
          ],
        ),
      ),
    );
  }
}
