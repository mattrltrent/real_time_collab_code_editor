import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uvec/screens/editor.dart';

final GoRouter router = GoRouter(
  onException: (context, state, router) => router.go("/error"), // not implemented, just place holder
  routes: <GoRoute>[
    GoRoute(path: '/', builder: (BuildContext context, GoRouterState state) => const EditorScreen()),
  ],
);
