import 'package:flutter/material.dart';

void main() {
  runApp(const UnphuSsianoApp());
}

class UnphuSsianoApp extends StatelessWidget {
  const UnphuSsianoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNPHU-SSIANO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF17643D)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('UNPHU-SSIANO')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.explore_outlined,
                    size: 72,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Encuentra tu camino en el campus',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('UNPHU-MAP', style: theme.textTheme.titleLarge),
                          const SizedBox(height: 12),
                          const Text(
                            'Tu espacio para encontrar edificios y aulas.',
                          ),
                          const SizedBox(height: 24),
                          FilledButton.icon(
                            onPressed: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) => const CampusMapPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.map_outlined),
                            label: const Text('Explorar el campus'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CampusMapPage extends StatefulWidget {
  const CampusMapPage({super.key});

  @override
  State<CampusMapPage> createState() => _CampusMapPageState();
}

class _CampusMapPageState extends State<CampusMapPage> {
  static const _demoDestinations = <String>[
    'Edificio A',
    'Edificio B',
    'Biblioteca',
    'Aula A-101',
    'Aula B-202',
  ];

  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = _query.trim().toLowerCase();
    final matches = _demoDestinations
        .where((destination) => destination.toLowerCase().contains(query))
        .toList();
    final resultLabel = matches.length == 1
        ? '1 resultado'
        : '${matches.length} resultados';

    return Scaffold(
      appBar: AppBar(
        title: const Text('UNPHU-MAP'),
        leading: IconButton(
          tooltip: 'Volver al inicio',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: const EdgeInsets.all(24),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Text(
                  'Destinos de demostración',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                const Text('Estos lugares son ficticios.'),
                const SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  autocorrect: false,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    setState(() {
                      _query = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Buscar edificio o aula',
                    hintText: 'Ejemplo: biblioteca o A-101',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Limpiar búsqueda',
                            onPressed: _clearSearch,
                            icon: const Icon(Icons.close),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(liveRegion: true, child: Text(resultLabel)),
                const SizedBox(height: 8),
                if (matches.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      'No encontramos coincidencias.\n'
                      'Prueba otro nombre o código.',
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  for (final destination in matches)
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.place_outlined),
                        title: Text(destination),
                        subtitle: const Text('Destino de demostración'),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
