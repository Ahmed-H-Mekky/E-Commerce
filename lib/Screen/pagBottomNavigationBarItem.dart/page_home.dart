import 'package:e_commerce/cubit/cubitGet/cubit/cuibit_all_category.dart';
import 'package:e_commerce/cubit/cubitGet/cubit/cuibte_get.dart';
import 'package:e_commerce/cubit/cubitGet/state/state_all_category.dart';
import 'package:e_commerce/cubit/cubitGet/state/states_get.dart';
import 'package:e_commerce/helps/showe_snake_bare.dart';
import 'package:e_commerce/widget/custom_list_view.dart';
import 'package:e_commerce/widget/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pagehome extends StatelessWidget {
  const Pagehome({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BlocBuilder<CuibitAllCategory, StateAllCategory>(
            builder: (context, state) {
              if (state is LoadingStateCategory) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SuccessStateCategory) {
                return CustomListView(state: state);
              } else if (state is FailureStateCategory) {
                showSnakeBare(
                  context: context,
                  message: Text(state.message.toString()),
                );
              }
              return const Center(child: Text('جاري تحميل البيانات...'));
            },
          ),
        ),

        BlocBuilder<CuibteAllProduect, StatesAllProduect>(
          builder: (context, state) {
            if (state is LoadingStateAllProduect) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is SuccessStateAllProduect) {
              return SliverPadding(
                padding: const EdgeInsets.only(top: 110.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CustomStack(data: state.data[index]);
                  }, childCount: state.data.length),
                ),
              );
            } else if (state is FailureStateAllProduect) {
              showSnakeBare(
                context: context,
                message: Text(state.message.toString()),
              );
              return const SliverToBoxAdapter(
                child: Center(child: Text('حدث خطأ أثناء تحميل البيانات')),
              );
            }
            return const SliverToBoxAdapter(
              child: Center(child: Text('... جاري تحميل البيانات ')),
            );
          },
        ),
      ],
    );
  }
}
