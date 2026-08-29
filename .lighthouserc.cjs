module.exports = {
  ci: {
    collect: {
      startServerCommand: 'pnpm dev',
      url: ['http://localhost:8888/'],
      startServerReadyPattern: 'Build successful',
    },
    assert: {
      assertions: {
        'errors-in-console': 'warn',
        'font-display': 'warn',
        'image-delivery-insight': 'warn',
        'network-dependency-tree-insight': 'warn',
        'unsized-images': 'warn',
        'unused-javascript': 'warn',
        'uses-rel-preconnect': 'warn',
        'uses-responsive-images': 'warn',
        'valid-source-maps': 'warn',
      },
    },
  },
};
