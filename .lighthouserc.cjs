module.exports = {
  ci: {
    collect: {
      startServerCommand: 'pnpm dev',
      url: ['http://localhost:8888/'],
      startServerReadyPattern: 'Build successful',
    },
  },
};
