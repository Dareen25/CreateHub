import 'package:flutter/material.dart';

import '../../../../core/constants/color_manager.dart';
import '../../../../l10n/generated/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final categories = [
      (
        l10n.artists,
        l10n.artistsSubtitle,
        Icons.palette_outlined,
        AppColors.peach,
      ),
      (
        l10n.diyMakers,
        l10n.diyMakersSubtitle,
        Icons.handyman_outlined,
        AppColors.mint,
      ),
      (
        l10n.handmade,
        l10n.handmadeSubtitle,
        Icons.card_giftcard,
        AppColors.lavender,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.notifications,
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                tooltip: l10n.filters,
                onPressed: () {},
                icon: const Icon(Icons.tune_rounded),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.peach,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.heroTitle,
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.heroDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                FilledButton(onPressed: () {}, child: Text(l10n.shopNow)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.exploreCreateHub,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          for (final category in categories)
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundColor: category.$4,
                  foregroundColor: AppColors.primary,
                  child: Icon(category.$3),
                ),
                title: Text(category.$1),
                subtitle: Text(category.$2),
                trailing: Icon(
                  Icons.chevron_right,
                  color: colors.onSurfaceVariant,
                ),
                onTap: () {},
              ),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.popularCategories,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(onPressed: () {}, child: Text(l10n.seeAll)),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CategoryChip(
                label: l10n.paints,
                icon: Icons.color_lens_outlined,
              ),
              _CategoryChip(label: l10n.brushes, icon: Icons.brush_outlined),
              _CategoryChip(label: l10n.canvases, icon: Icons.crop_portrait),
              _CategoryChip(label: l10n.wood, icon: Icons.forest_outlined),
              _CategoryChip(
                label: l10n.plants,
                icon: Icons.local_florist_outlined,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.featuredProducts,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(l10n.catalogPlaceholder),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Chip(
    avatar: Icon(icon, size: 18),
    label: Text(label),
    backgroundColor: AppColors.cream,
    side: BorderSide.none,
  );
}
