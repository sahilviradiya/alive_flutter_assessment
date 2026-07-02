import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/home_viewmodel.dart';
import 'stream_card.dart';

class StreamGrid extends StatelessWidget {
  const StreamGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: viewModel.streams.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.74,
          ),
          itemBuilder: (context, index) {
            return StreamCard(stream: viewModel.streams[index]);
          },
        );
      },
    );
  }
}
